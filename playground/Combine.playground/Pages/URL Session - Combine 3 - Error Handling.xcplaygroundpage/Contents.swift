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

// Reading network data - note: this API results in 50% errors.
func unstablyFetchPersons() -> AnyPublisher<People, any Error> {
    return URLSession.shared.dataTaskPublisher(for: url)
        .map { $0.data}
        .decode(type: People.self, decoder: JSONDecoder())
//        .replaceError(with: People(persons: [Person]()))          // Not handling error here.
        .eraseToAnyPublisher()
}

let publisher1:AnyPublisher<People, any Error> = unstablyFetchPersons()

let cancellable1 = publisher1
    .sink { completion in                                           // Subscribers must handle error by themselve.
        switch (completion) {
        case .finished:
            break
        case .failure(let error):
            print("1) Error: \(error)")
        }
    } receiveValue: { people in
        print("1) People: \(people)")
    }

// MARK: - Handle (and hide) error inside Publisher

func unstablyFetchPersons2() -> AnyPublisher<People, Never> {
    return URLSession.shared.dataTaskPublisher(for: url)
        .map { $0.data}
        .decode(type: People.self, decoder: JSONDecoder())
        .replaceError(with: People(persons: [Person]()))            // If error, replace with an empty array.
        .eraseToAnyPublisher()
}

let cancellable2 = unstablyFetchPersons2()
    .sink { print("2) People: \($0)") }

// MARK: - Using `tryMap()`

func unstablyFetchPersons3() -> AnyPublisher<People, Error> {
    return URLSession.shared.dataTaskPublisher(for: url)
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

let cancellable3 = unstablyFetchPersons3()
    .sink { completion in
        print("3) completion with \(completion)")
    } receiveValue: { people in
        print("3) People: \(people)")
    }

// MARK: - Full error handling: Using Retry, then Try Map and Replace With

func unstablyFetchPersons4() -> AnyPublisher<People, Error> {
    return URLSession.shared.dataTaskPublisher(for: url)
        .tryMap({ element -> Data in
            guard let httpResp = element.response as? HTTPURLResponse,
                  httpResp.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            return element.data
        })
        .retry(3)
        .decode(type: People.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
}

let cancellable4 = unstablyFetchPersons4()
    .sink { completion in
        print("4) completion with \(completion)")
    } receiveValue: { people in
        print("4) People: \(people)")
    }


