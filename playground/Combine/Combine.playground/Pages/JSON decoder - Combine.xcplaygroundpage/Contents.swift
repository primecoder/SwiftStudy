/// The simplest form of using Combine to decode JSON data.
///
/// - Author: Ace Authors
///
import Foundation
import Combine

// Get the data from resource bundle.
guard let dataFile = Bundle.main.path(forResource: "reviews", ofType: "json") else {
    print("ERROR> Cannot find data file: reviews.json")
    exit(0)
}

do {
    let data = try Data(contentsOf: URL(fileURLWithPath: dataFile))
    Just(data)
        .decode(type: Reviews.self, decoder: JSONDecoder())
        .sink { (completion) in
            print("Completed")
        } receiveValue: { (reviews) in
            _ = reviews.map { print("Review: \($0.text), label: \($0.label)") }
        }

} catch {
    print("ERROR> \(error)")
}

