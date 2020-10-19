
/// In this playground, we are looking at an alternative implementation of Timer using Combine Framework.
///
/// - Author: Ace Authors
///

import Foundation
import Combine

// Simplest timer using Combine.
let cancellable = Timer.publish(every: 1, on: .main, in: .default)
    .autoconnect()
    .sink { time in
        print("1> \(time)")
    }


// NOTE:
// - Need to store the value returned by 'zink' (in cancellable2) to keep it in scope,
//   or else the timer will not run.
var repeatCount = 0
let timer = Timer.publish(every: 1, on: .main, in: .default)
let cancellable2 = timer.sink(receiveCompletion: { _ in
    print("2> All done")
}, receiveValue: { time in
    repeatCount += 1
    print("2> count=\(repeatCount), time: \(time)")
    if repeatCount >= 5 {
        timer.connect().cancel()
        cancellable.cancel()
    }
})

// This will start the timer and run the code block above.
timer.connect()

