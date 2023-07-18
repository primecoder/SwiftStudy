/// Codable JSON data - no Combine
///
/// In this playground, I had a look at how Combine can be used
/// in the pattern of read-translate-serialise data into objects.
///

import Foundation

// MARK: -

// Get the data from resource bundle.
guard let dataFile = Bundle.main.path(forResource: "reviews", ofType: "json") else {
    print("ERROR> Cannot find data file: reviews.json")
    exit(0)
}

do {
    let data = try Data(contentsOf: URL(fileURLWithPath: dataFile))
    try JSONDecoder()
        .decode(Reviews.self, from: data)
        .map { print("Review: \($0.text), label: \($0.label)") }
} catch {
    print("ERROR> \(error)")
}

