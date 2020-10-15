/// My study on Combine Framework
///
/// - Author: Ace Authors
///

import Cocoa
import Combine

//- The simplest Combine code -----------

// Simple publisher, emits output just once with a given value.
let publisher = Just("Hello")

// Connect publisher to subscriber with Sink!
// Subscriber, in this case, with Sink, is closures.
publisher.sink { _ in
    print("finished")
} receiveValue: { (value) in
    print("Value: \(value)")
}



