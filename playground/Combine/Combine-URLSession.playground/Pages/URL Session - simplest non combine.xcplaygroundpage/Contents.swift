/// Using URL session - the old way, i.e. no Combine
///
/// - see:
///     - https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory
///
/// - author: Ace Authors (aa)
///

import Foundation

let url = URL(string: "http://pi-one:5000/events/api/v1.0/mock")!

// Simplest form of URLSession.
let task = URLSession.shared.dataTask(with: url) { data, response, error in
    if let resp = response { print("Response> \(resp)") }
}
task.resume()
