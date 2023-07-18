/// My study on Combine Framework
///
/// - Author: Ace Authors
///
/// - History:
///     2021.03.14 - Revisited and documentation

import Cocoa
import Combine

//- The simplest Combine code -----------

// Simple publisher, emits output just once with a given value.
let publisher = Just<String>("Hello")   // Full form
// let publisher = Just("Hello")        // Simplified form


// Connect publisher to subscriber with Sink!
// Subscriber, in this case, with Sink, is closures.
publisher.sink { completion in
    print("finished: \(completion)")
} receiveValue: { (value) in
    print("Value: \(value)")
}



