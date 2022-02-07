import Foundation
import Combine

struct Persons: Codable {
    let persons: [Person]
}

struct Person: Codable {
    let birthdate: String
    let id: Int
    let name, surname: String
}

let url = URL(string: "http://127.0.0.1:5000/persons")!

func fetchPersons() -> AnyPublisher<Persons, Never> {
    return URLSession.shared.dataTaskPublisher(for: url)
        .map { $0.data}
        .decode(type: Persons.self, decoder: JSONDecoder())
        .replaceError(with: Persons(persons: [Person]()))
        .eraseToAnyPublisher()
}

// (1) Convert Persons.persons to an array [Person]
// (2) Subscribe and iterate through an array [Person]. Note that `sink` only process
//     publisher with `Never` failure.
// (3) Notice fetchPersons() run asynchronously and also Person server is throttled
//     with 5-second delay.
print("Start fetch ...")
var cancellables = Set<AnyCancellable>()
fetchPersons()
    .map { $0.persons.map { $0 } }                      // (1)
    .sink { _ = $0.map { print("Fetch 1> \($0)") } }    // (2)
    .store(in: &cancellables)
print("End fetch ...")                                  // (3)

// (4) Conversion is done in publisher. Convert from Persons.persons -> [Person]
func fetchPersons2() -> AnyPublisher<[Person], Never> {
    return URLSession.shared.dataTaskPublisher(for: url)
        .map { $0.data }
        .decode(type: Persons.self, decoder: JSONDecoder())
        .replaceError(with: Persons(persons: [Person]()))
        .map { $0.persons }                                 // (4)
        .eraseToAnyPublisher()
}

print("Start fetch 2 ...")
var cancellables2 = Set<AnyCancellable>()
fetchPersons2()
    .sink { _ = $0.map { print("Fetch 2> \($0)") } }
    .store(in: &cancellables2)
