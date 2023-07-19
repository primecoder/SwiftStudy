import Foundation
import Combine
import SwiftUI
import PlaygroundSupport    // Need to import this one to view SwiftUI inside Playground.

// This will display SwiftUI contents.
PlaygroundPage.current.setLiveView(
    PeopleView(viewModel: ViewModel())
)

// SwiftUI PeopleView demonstrates:
// MVVM - how view layer only focus on the display functionality
//        and ViewModel taking cares for all the low-level details.
struct PeopleView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button("Test Data") { viewModel.loadWithTestData() }
                Button("Reload") { viewModel.loadData() }
                    .disabled(viewModel.status == .loading)
            }
            HStack {
                Text("Status:")
                Text(viewModel.status.rawValue)
                switch (viewModel.status) {
                case .ready:
                    Text("(loaded \(viewModel.loadBytes) bytes)")
                case .loading:
                    Text("(attempt #\(viewModel.attemptCount))")
                default:
                    Text("")
                }
            }
            Divider()
            ScrollView {
                if (viewModel.status != .loading) {
                    ForEach(viewModel.people.persons) { person in
                        PersonView(person: person)
                    }
                }
            }
            .overlay(viewModel.status == .loading ? ProgressView() : nil)
        }
        .frame(width: 400, height: 500)
    }
}

struct PersonView: View {
    var person: Person
    
    var body: some View {
        Text("\(person.name) \(person.surname)")
            .padding(5)
            .frame(maxWidth: .infinity)
            .foregroundColor(Color.black)
            .background(Color.white)
            .cornerRadius(5)
    }
}

class ViewModel: ObservableObject {
    enum Status: String {
        case initialised = "Initialised"
        case loading = "Loading..."
        case loadError = "Error"
        case ready = "Ready"
    }
    
    @Published var status: Status = .initialised
    @Published var people: People = People()
    @Published var loadBytes: Int = 0
    @Published var attemptCount: Int = 1
    
    // For REST service, see:
    // https://github.com/primecoder/Simple-REST-Services/tree/main
    // Note the uses of `unstable` API where 50% of calls will fail.
    private static let url = URL(string: "http://127.0.0.1:5000/unstable/persons")!
    
    // This function returns a Publisher which can be used locally inside a function.
    // I need the lifecycle of this publisher to be short-live as I use `share()` here.
    // When a publisher lifescope is in the bigger/wider scope, the "reload" function
    // doesn't work.
    //
    // (1) `map` is used to execute extra steps with no conversion to the stream of data.
    //     Note the use of `[self]` captured-list as `self` is referred to inside closure.
    // (2) Simply return the same data with no conversion.
    // (3) Use `retry()` for error handling - i.e. network error.
    //     Here, all upstreams will be retried up to 3 attempts. Hence, the `map` will be
    //     called up to 3 times, see (1).
    // (4) Use `share()` to share this publisher with more than one subscriber.
    //     The downside of doing this - is that if this publisher continue to live on,
    //     I cannot do another 'reload' operation (i.e. from clicking "reload" button).
    private func makePublisher() -> AnyPublisher<Data, Error> {
        attemptCount = 1
        return URLSession.shared
            .dataTaskPublisher(for: ViewModel.url)
            .map { [self]                                                       // (1)
                print("attemp count: \(self.attemptCount)")
                self.attemptCount += 1
                return $0                                                       // (2)
            }
            .tryMap({ element -> Data in
                guard let httpResp = element.response as? HTTPURLResponse,
                      httpResp.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            })
            .retry(3)                                                           // (3)
            .print("Loading")
            .share()                                                            // (4)
            .eraseToAnyPublisher()
    }
    
    // For storing all the cancellables.
    // Cancellables, on the other hands, must live on long enough to complete entire
    // operations.
    private var cancellables = Set<AnyCancellable>()
    
    private func clearAllCancellables() {
        for cancellable in self.cancellables {
            print("Cancels one cancellable")
            cancellable.cancel()
        }
        cancellables.removeAll()
    }
    
    // This function is used when working on the UI elements.
    func loadWithTestData() {
        people = People.mockedPeople
        status = .ready
    }
    
    // Demonstrate loading data from network with a single network call and multiple
    // subscribers.
    func loadData() {
        clearAllCancellables()
        status = .loading
        
        let publisher = makePublisher()
        
        // Subscriber 1, converts data to People and persons.
        publisher
            .decode(type: People.self, decoder: JSONDecoder())
            .replaceError(with: People(persons: []))
            .sink { [self] completion in
                switch (completion) {
                case .finished:
                    self.status = .ready
                case .failure(_):
                    self.status = .loadError
                }
            } receiveValue: { [self] people in
                self.people = people
            }
            .store(in: &cancellables)
        
        // Subscriber 2, monitors how many bytes are read from network.
        publisher
            .sink { completion in
                // Do nothing here.
            } receiveValue: { [self] data in
                print("Data: \(data.count)")
                self.loadBytes = data.count
            }
            .store(in: &cancellables)
    }
}
