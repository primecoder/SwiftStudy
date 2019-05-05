/*:
 Study Escaping Function/Closure

 Demonstrates the 2nd possibility of when escaping closure is needed.

 What is Escaping Closure?
 A closure is said to escape a function when the closure is passed as an argument to the function, but is called after the function returns.
 (from: https://docs.swift.org/swift-book/LanguageGuide/Closures.html)

 - Author: Ace Authors
 */

import Foundation

/// Array of functions
var funArray: [(String) -> ()] = []

/// This simulates a function which will be called inside the long-running operation.
func announceMsg(_ msg: String) { print(msg) }

/// This function add an input code block (function/closure) to an array which may outlive
/// the live of the function - hence, the need for @escaping clause.
func addMoreFun(_ someFun: @escaping (String) -> ()) {
    funArray.append(someFun)
}

addMoreFun(announceMsg(_:))
addMoreFun {(msg) in print("So much \(msg)")}

// The function addMoreFun() is long gone, but
// those code blocks added by the function are accessed later here.
for fun in funArray {
    fun("Fun")
}


/*:
 History
 - 2019.04.29 Created by Ace
 */
