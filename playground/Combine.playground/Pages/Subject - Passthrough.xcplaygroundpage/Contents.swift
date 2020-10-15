
import Foundation
import Combine

// Subject - A publisher that can be used to inject values into a stream.
// PassthroughSubject is one implementation that conforms to Subject protocol.
let subj = PassthroughSubject<String, Never>()

// Connect publisher (a subject) to subscribers (closures).
subj.sink { (_) in
    print("Finished")
} receiveValue: { (value) in
    print("Value: \(value)")
}

subj.send("Hello!")
subj.send("Ace says 'Hi!' to Swift's Combine")

//- Register 2nd subscriber!
subj.sink { (_) in
    print("Finished2")
} receiveValue: { (value) in
    print("Value2: \(value)")
}

subj.send("Wow! Now I have more subscribers!!!")

// Finally, we are done - send finished.
subj.send(completion: .finished)
