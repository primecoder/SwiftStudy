
import Foundation
import Combine

// Subject - A publisher that can be used to inject values into a stream.
// PassthroughSubject is one implementation that conforms to Subject protocol.
let subj = PassthroughSubject<String, Never>()

// Connect publisher (a subject) to subscribers (closures).
subj.sink
let cancellable1 = subj.sink { (_) in
    print("Subscriber1 > Finished")
} receiveValue: { (value) in
    print("Subscriber1 > Value: \(value)")
}

// Now, inject values to publishing stream.
subj.send("Hello!")
subj.send("Ace says 'Hi!' to Swift's Combine")

//- Register 2nd subscriber!
let cancellable2 = subj.sink { (_) in
    print("Subscriber2 > Finished")
} receiveValue: { (value) in
    print("Subscriber2 > Value2: \(value)")
}

subj.send("Wow! Now I have more subscribers!!!")

// Subscriber1 cancells.
cancellable1.cancel()

subj.send("Oh no! Now I have less subscriber!")

// Finally, we are done - send finished.
subj.send(completion: .finished)
