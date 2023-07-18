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

//let url = URL(string: "http://127.0.0.1:5000/unstable/persons")!
let url = URL(string: "http://127.0.0.1:5000/persons")!

func fetchPersons() -> AnyPublisher<People, Error> {
    return URLSession.shared.dataTaskPublisher(for: url)
        .print("unshared")
        .tryMap({ element -> Data in
            guard let httpResp = element.response as? HTTPURLResponse,
                  httpResp.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            return element.data
        })
        .decode(type: People.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
}

let publisher = fetchPersons()

let cancellable1 = publisher
    .sink { completion in
        print("1) Completed: \(completion)")
    } receiveValue: { people in
        print("1) People: \(people.persons.count)")
    }

let cancellable2 = publisher
    .sink { completion in
        print("2) Completed: \(completion)")
    } receiveValue: { people in
        print("2) People: \(people.persons.count)")
    }

func sharedFetchPersons() -> AnyPublisher<People, Error> {
    return URLSession.shared.dataTaskPublisher(for: url)
        .print("shared")
        .tryMap({ element -> Data in
            guard let httpResp = element.response as? HTTPURLResponse,
                  httpResp.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            return element.data
        })
        .decode(type: People.self, decoder: JSONDecoder())
        .share()
        .eraseToAnyPublisher()
}

let sharedPublisher = sharedFetchPersons()

let cancellable3 = sharedPublisher
    .sink { completion in
        print("3) Completed: \(completion)")
    } receiveValue: { people in
        print("3) People: \(people.persons.count)")
    }

let cancellable4 = sharedPublisher
    .sink { completion in
        print("4) Completed: \(completion)")
    } receiveValue: { people in
        print("4) People: \(people.persons.count)")
    }

let cancellable5 = sharedPublisher
    .sink { completion in
        print("5) Completed: \(completion)")
    } receiveValue: { people in
        print("5) People: \(people.persons.count)")
    }

let cancellable6 = sharedPublisher
    .sink { completion in
        print("6) Completed: \(completion)")
    } receiveValue: { people in
        print("6) People: \(people.persons.count)")
    }

