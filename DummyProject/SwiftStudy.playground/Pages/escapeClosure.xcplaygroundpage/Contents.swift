/*:
 Study Escaping Function/Closure

 Demonstrates one of the scenario where escaping closure is needed.

 What is Escaping Closure?
    A closure is said to escape a function when the closure is passed as an argument to the function, but is called after the function returns.
    (from: https://docs.swift.org/swift-book/LanguageGuide/Closures.html)

 - Author: Ace Authors
 */

import Foundation

/**
 This simulates a function which will be called inside the long-running operation.
 */
func announceMsg(_ msg: String) {print(msg)}

/**
 This function simulates the long-running operation in asynchronous mode - it does not block the execution and returns immediately.
 Note, it demonstrates calling the same function at 2 different places:

 1. Inside the function

 2. Outside the function (part of asyn queue)
    By the time a function is called, the caller (parent) may already exit.
 */
func longRunningOp(_ opName: String,
                    delaySecond: Int,
                    announcer: (String) -> (),
                    escapingAnnouncer: @escaping (String) -> ()) {
    announcer("\(opName): enter")
    let dispatchQueue = DispatchQueue(label: opName)
    dispatchQueue.async {
        escapingAnnouncer("\(dispatchQueue.label): start long running process...")
        usleep(1000000 * UInt32(delaySecond))
        escapingAnnouncer("\(dispatchQueue.label): completed long running process")
    }
    announcer("\(opName): exit")

}

// Calling with functions
longRunningOp("A2",
              delaySecond: 10,
              announcer: announceMsg(_:),
              escapingAnnouncer: announceMsg(_:))

// Calling with closure blocks
longRunningOp("B2",
              delaySecond: 3,
              announcer: {(msg) in print("(closure) \(msg)")}
    ) {(msg) in print("(escaping closure) \(msg)")}


/*:
 History
 - 2019.04.29 Created by Ace
 */
