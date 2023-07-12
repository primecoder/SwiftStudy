import Foundation

// Demonstrate how to put a (swift) file in a shared Source folder for playground.

public struct Person {
    public var firstName: String
    public var lastName: String

    public init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }

}

extension Person: CustomStringConvertible {
    public var description: String {
        return "\(self.firstName) \(self.lastName)"
    }
}
