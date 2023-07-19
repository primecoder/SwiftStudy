import Foundation
import Combine
import SwiftUI
import PlaygroundSupport    // Need to import this one.

// This will display SwiftUI contents.
PlaygroundPage.current.setLiveView(
    PeopleView(viewModel: ViewModel())
)

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
                Text("(loaded \(viewModel.loadBytes) bytes)")
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
        .frame(width: 600, height: 400)
    }
}

struct PersonView: View {
    var person: Person
    
    var body: some View {
        Text("\(person.name) \(person.surname)")
    }
}

class ViewModel: ObservableObject {
    enum Status: String {
        case initialising = "Initialising"
        case loading = "Loading..."
        case loadError = "Error"
        case ready = "Ready"
    }
    
    @Published var status: Status = .initialising
    @Published var people: People = People()
    @Published var loadBytes: Int = 0
    
    private static let url = URL(string: "http://127.0.0.1:5000/unstable/persons")!
    
    private func makePublisher() -> AnyPublisher<Data, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: ViewModel.url)
            .tryMap({ element -> Data in
                guard let httpResp = element.response as? HTTPURLResponse,
                      httpResp.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            })
            .retry(3)
            .print("Loading")
            .share()
            .eraseToAnyPublisher()
    }
    
    // For storing all the cancellables.
    private var cancellables = Set<AnyCancellable>()
    
    private func clearAllCancellables() {
        for cancellable in self.cancellables {
            print("Cancels one cancellable")
            cancellable.cancel()
        }
        cancellables.removeAll()
    }
    
    func loadWithTestData() {
        people = People.mockedPeople
    }
    
    func loadData() {
        clearAllCancellables()
        status = .loading
        
        let publisher = makePublisher()
        
        publisher
            .decode(type: People.self, decoder: JSONDecoder())
            .sink { completion in
                switch (completion) {
                case .finished:
                    self.status = .ready
                case .failure(_):
                    self.status = .loadError
                }
            } receiveValue: { people in
                self.people = people
            }
            .store(in: &cancellables)
        
        publisher
            .sink { completion in
                //
            } receiveValue: { data in
                print("Data: \(data.count)")
                self.loadBytes = data.count
            }
            .store(in: &cancellables)

    }
}
