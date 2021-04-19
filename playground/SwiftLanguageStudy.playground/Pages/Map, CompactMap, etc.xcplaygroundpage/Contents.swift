/// Swift Language Study
///
/// Map, Flatmap, Filter, and the likes
///
/// History:
/// - 2021.04.19, Ace, Created

import Foundation

let user1 = "John Doe"

// Long form
let result1 = user1.map { (ch) -> Character in
    print(ch)
    return ch
}
print("Result1 count: \(result1.count), results: \(result1)")

// Compact form
let result2 = user1.map { (ch) in ch }
print("Result2 count: \(result2.count), results: \(result2)")

// Even more compact
let result3a = user1.map { $0.asciiValue }
let result3b = user1.compactMap { $0.asciiValue }
print("Result3a count: \(result3a.count), results: \(result3a)")
print("Result3b count: \(result3b.count), results: \(result3b)")

// This one takes 4 passes, but more descriptive - easy to understand
let encrypted1 = user1
    .compactMap { $0.asciiValue }           // Compact array of ascii values
    .map { $0 + 1 }                         // Change each by +1
    .map { Unicode.Scalar($0) }             // Convert to array of Unicode.Scalar
    .map { Character($0) }                  // Convert to array of char
print("encrypted1: \(String(encrypted1))")

// Optimised performance - only 2 passes.
let encrypted2 = user1
    .compactMap { $0.asciiValue }
    .map { Character(Unicode.Scalar($0 + 1)) }
print("encrypted2: \(String(encrypted2))")
