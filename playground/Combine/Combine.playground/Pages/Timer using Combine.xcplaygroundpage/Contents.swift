
/// In this playground, we are looking at an alternative implementation of Timer using Combine Framework.
///
/// - Author: Ace Authors
///

import Foundation
import Combine

// Simplest timer using Combine.
let cancellable1 = Timer.publish(every: 1, on: .main, in: .default)
    .autoconnect()  // Auto connect to timer and run straight away
    .sink { time in
        print("1> \(time)")
    }


// NOTE:
// - Need to store the value returned by 'sink' (in cancellable2) to keep it in scope,
//   or else the timer will not run.
let timer = Timer.publish(every: 1, on: .main, in: .default)

var cancellable2Count = 0
let cancellable2 = timer.sink(receiveCompletion: { _ in
    print("2> All done")
}, receiveValue: { time in
    cancellable2Count += 1
    print("2> count=\(cancellable2Count), time: \(time)")
    if cancellable2Count >= 5 {
        
        // These 2 lines work the same.
//        timer.connect().cancel()    // Cancel the 2nd timer. Connect first then cancel.
        cancellable2.cancel()
        
        cancellable1.cancel()        // Cancel the first timer. See line 11
    }
})

var cancellable3Count = 0
let cancellable3 = timer.sink { _ in
    print("3> All done")
} receiveValue: { time in
    cancellable3Count += 1
    print("3> count=\(cancellable3Count), time: \(time)")
    if cancellable3Count >= 10 {
        cancellable3.cancel()
    }
}

let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "YYYY-MM-dd HH:ss"
var cancellable4Count = 0
let cancellable4 = timer
    .map { dateFormatter.string(from: $0) }         // Using operator to convert time to string and republish as string.
    .map { ">>>>> \($0) <<<<<"}                     // More conversion here
    .sink { _ in
        print("4> All done")
    } receiveValue: { timeDesc in
        cancellable4Count += 1
        print("4> count=\(cancellable4Count), time: \(timeDesc)")
        if cancellable4Count >= 3 {
            cancellable4.cancel()
        }
    }


// When not using autoconnect(), timer will not start publishing until manually connect.
// This will start the timer and calls to all subscribers (cancellable2/3/4)
timer.connect()

print("All Done")
