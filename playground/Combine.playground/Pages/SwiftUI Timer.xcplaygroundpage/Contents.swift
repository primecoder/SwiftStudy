
import SwiftUI
import PlaygroundSupport    // Need to import this one.
import Combine

struct DigitalClock: View {
    
    @ObservedObject var dataModel: DataModel
    
    var body: some View {
        VStack {
            Text("Time: \(dataModel.timeHHMMSS)")
                .font(.title)
            Divider()
            HStack {
                Text("Time: \(dataModel.timeHHMM)")
                    .font(.largeTitle)
                ZStack {
                    ProgressView(value: Double(dataModel.seconds), total: 60)
                        .progressViewStyle(.circular)
                    Text("\(dataModel.seconds)")
                }
                .padding()
            }
        }
        .padding()
        .frame(width: 300)
        .background(Color.white)
        .foregroundColor(Color.black)
        .cornerRadius(15)
        .padding()
    }
}

// This will display SwiftUI contents.
PlaygroundPage.current.setLiveView(
    DigitalClock(
        dataModel: DataModel().start()
    )
)

// This DataModel demonstrates how to encapsulate (hide) all implementation details.
// It hides the uses of Combine Framework inside.
// The caller (SwiftUI view) only needs to concern about updatable object and how to
// display it.
// [aa-20230717]
class DataModel: ObservableObject {
    @Published var timeHHMMSS: String = "--:--:--"
    @Published var timeHHMM: String = "--:--"
    @Published var seconds: Int = 0
    
    private static let dateFormatter = {
        let fmt = DateFormatter()
        fmt.dateFormat = "HH:mm:ss"
        return fmt
    }()
    
    private static let dateFormatterHHMM = {
        let fmt = DateFormatter()
        fmt.dateFormat = "HH:mm"
        return fmt
    }()
    
    // Timer.TimerPublisher conforms to `ConnectablePublisher` - so, use `connect()` or `autoconnect()` to
    // start collecting data.
    private var timer = Timer.publish(every: 1, on: .main, in: .default)
    private var cancellable1: AnyCancellable?
    private var cancellable2: AnyCancellable?
    private var cancellable3: AnyCancellable?
    
    func start() -> DataModel {
        if (cancellable1 == nil) {
            cancellable1 = timer
            //        .autoconnect()
                .map { DataModel.dateFormatter.string(from: $0) }
                .assign(to: \.timeHHMMSS, on: self)       // Example of how to use `assign(to:)`
            //        .sink { self.time = $0 }
        }
        
        if (cancellable2 == nil) {
            cancellable2 = timer
                .map { DataModel.dateFormatterHHMM.string(from: $0) }
                .assign(to: \.timeHHMM, on: self)
        }
        
        if (cancellable3 == nil) {
            cancellable3 = timer
                .map { Int($0.timeIntervalSince1970) % 60 }
                .assign(to: \.seconds, on: self)
        }
        
        // This shows an example of connecting manually
        timer.connect()
        
        return self
    }
}
