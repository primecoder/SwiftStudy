/// Using KVO with Combine
///
/// - Authors: Ace Authors
///


import Foundation
import Combine

class User: NSObject {
    // This needs both '@objc' and 'dynamic' to make this KVO happens.
    @objc dynamic var firstName: String

    init(_ firstName: String) {
        self.firstName = firstName
    }
}

var tom = User("Tom")
print("> User: \(tom.firstName)")

let cancellable = tom.publisher(for: \.firstName)
    .sink(receiveValue: { (name) in
        print("A user changed name to: \(name)")
    })

tom.firstName = "Tommy"
tom.firstName = "Thomas"

print("> User: \(tom.firstName)")

// Now, cancel this KVO publication.
cancellable.cancel()

tom.firstName = "Thomas the Tank Engine"
print("> User: \(tom.firstName)")

print("End")
