/// The simplest form of using Combine to decode JSON data.
///
/// - Author: Ace Authors
///
import Foundation
import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, Error> {
  let decoder = JSONDecoder()
  decoder.dateDecodingStrategy = .secondsSince1970

  return Just(data)
    .decode(type: T.self, decoder: decoder)
    .eraseToAnyPublisher()
}

// Get the data from resource bundle.
guard let dataFile = Bundle.main.path(forResource: "reviews", ofType: "json") else {
    print("ERROR> Cannot find data file: reviews.json")
    exit(0)
}

do {
    let data = try Data(contentsOf: URL(fileURLWithPath: dataFile))

    
    let dataPublisher: AnyPublisher<Reviews, Error> = decode(data)

    dataPublisher
        .map({ (reviews: Reviews) -> [String] in
            reviews.map { "\($0.label) <- \($0.text)" }
        })
        .sink { _ in
            print("Done")
        } receiveValue: { (texts) in
            for line in texts {
                print(line)
            }
        }

    dataPublisher
        .map({ (reviews: Reviews) -> [String] in
            reviews.map { "\($0.text) -> \($0.label)" }
        })
        .sink { _ in
            print("Done")
        } receiveValue: { (texts) in
            for line in texts {
                print(line)
            }
        }

} catch {
    print("ERROR> \(error)")
}

