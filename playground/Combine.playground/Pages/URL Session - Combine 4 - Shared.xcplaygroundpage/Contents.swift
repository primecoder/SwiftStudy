import Foundation
import Combine

struct People: Codable {
    let persons: [Person]
}

struct Person: Codable {
    let id: Int
    let birthdate: String
    let name: String
    let surname: String
}

let url = URL(string: "http://127.0.0.1:5000/unstable/persons")!
