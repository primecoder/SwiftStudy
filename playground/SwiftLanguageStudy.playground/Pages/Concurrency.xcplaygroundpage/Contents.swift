
import Foundation

func longAsyncOp(_ name: String) async throws -> [String] {
    print("longAsyncOp: \(name) starts")
    try await Task.sleep(until: .now + .seconds(2), clock: .continuous)
    print("longAsyncOp: \(name) ends")
    return ["IMG001", "IMG99", "IMG0404"]
}

// Task - to run async code - see "Unstructured Concurrency"
// https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/#Unstructured-Concurrency
print("Concurrency 1 begins")
Task {
    print("Task 1 begins")
    let photos = try? await longAsyncOp("Long Op 1")
    print("Task 1 ends")
}
print("Concurrency 1 ends")

print("Concurrency 2 begins")
Task {
    print("Task 2 begins")
    async let longOp1 = longAsyncOp("Op1")               // Continue next line immediately
    async let longOp2 = longAsyncOp("Op2")               // Continue next line immediately
    async let longOp3 = longAsyncOp("Op3")               // Continue next line immediately
    let results = try await [longOp1, longOp2, longOp3]  // Wait for longOp1, longOp2, and longOp3 here
    print("Task 2 ends")
}
print("Concurrency 2 ends")
