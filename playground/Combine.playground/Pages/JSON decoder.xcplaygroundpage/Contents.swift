/// Codable JSON data - no Combine
///
/// In this playground, I had a look at how Combine can be used
/// in the pattern of read-translate-serialise data into objects.
///

import Foundation
import Combine

// MARK: - Review
// Created using app.quicktype.io
struct Review: Codable {
    let text: String
    let label: Label
}

enum Label: String, Codable {
    case negative = "negative"
    case neutral = "neutral"
    case positive = "positive"
}

typealias Reviews = [Review]

// MARK: -

// Get the data from resource bundle.
guard let dataFile = Bundle.main.path(forResource: "reviews", ofType: "json") else {
    print("ERROR> Cannot find data file: reviews.json")
    exit(0)
}

do {
    let data = try Data(contentsOf: URL(fileURLWithPath: dataFile))
    let reviews = try JSONDecoder().decode(Reviews.self, from: data)
    for review in reviews {
        print("Review: \(review.text), label: \(review.label)")
    }
} catch {
    print("ERROR> \(error)")
}
