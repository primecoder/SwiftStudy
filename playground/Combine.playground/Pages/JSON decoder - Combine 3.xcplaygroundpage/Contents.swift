import Foundation
import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, Error> {
  let decoder = JSONDecoder()
  decoder.dateDecodingStrategy = .secondsSince1970

  return Just(data)
    .decode(type: T.self, decoder: decoder)
    .eraseToAnyPublisher()
}

