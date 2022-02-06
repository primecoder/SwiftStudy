/*: Demonstrate simple(st) Combine Framework with Network operations.
 
 Key features:
 
 1. Chained operator, i.e. converting data
 2. Subsribe to publisher to activate publisher
 3. Store cancellable object to retain the scope of excution
 
 
 History:
 
 - 2022.02.06, (aa), created
 
 */
import Foundation
import Combine

guard let url = URL(string: "http://127.0.0.1:5000/persons") else {
    exit(0)
}

print(url)

var cancellables = Set<AnyCancellable>()

URLSession.shared.dataTaskPublisher(for: url)
    .map { String(decoding: $0.data, as: UTF8.self) }       // Convert to string
    .sink(                                                  // Need a subscriber to start publishing
        receiveCompletion: { status in print("Completed: \(status)") },
        receiveValue: { data in print("data: \(data)") }
    )
    .store(in: &cancellables)       // Store cancellable so it won't go out of scope.

