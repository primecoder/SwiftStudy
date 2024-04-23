/*:
 Demonstrate how to use build-in property wrapper to make a publisher.

 - SeeAlso:
 - [Building custom Combine publishers in Swift](https://www.swiftbysundell.com/articles/building-custom-combine-publishers-in-swift/)

 - Authors: Ace
 - Since: 2024-04-23
 */
import Cocoa
import Combine

class MyList {

    // Property-wrapper emits new value when a property is changed.
    // To use property-wrapper, this must be class only, i.e. not for `struct`.
    @Published private(set) var items: [String] = []

    private let itemCounterSubject = CurrentValueSubject<Int, Never>(0)
    var itemCounterPublisher: AnyPublisher<Int, Never> {
        // This eraser effectively hides the implementation details
        // that it was using `CurrentValueSubject` and expose
        // the caller as simply `AnyPublisher`.
        itemCounterSubject.eraseToAnyPublisher()
    }

    func addItem(_ str: String) {
        items.append(str)
        itemCounterSubject.send(items.count)
    }
}

let items = MyList()

// 'sink' provide closure as a subscriber

let firstSubscriber = items.$items
    .sink { items in
        print("1> \(items)")
    }
let secondSubscriber = items.$items
    .compactMap { $0.last }
    .sink { item in
        print("2> \(item)")
    }
let itemCounterSubscriber = items.itemCounterPublisher
    .sink { itemCount in
        print("3> Items count: \(itemCount)")
    }

items.addItem("Hello!")
items.addItem("How are you?")
items.addItem("I am fine.")

// The different between `itemCounterSubscriber` closure and the line below is that
// closure code is executed asynchronously when changes occur (push-op).
// Whereas the code below, synchronously pull current value (pull-op).
print("\nCurrent items count: \(items.items.count)")

// Since we use `currentValue` subject, we can get the latest value here.
let itemCounterSubscriberFinal = items.itemCounterPublisher
    .sink { itemCount in
        print("Final> Items count: \(itemCount)")
    }

print("\nThis change triggers all subscribers.")
items.addItem("Good bye")
