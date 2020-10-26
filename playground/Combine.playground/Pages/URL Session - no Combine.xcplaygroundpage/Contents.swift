/// Using URL session - the old way, i.e. no Combine
///
/// - see:
///     - https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory
///
/// - author: Ace Authors (aa)
///

// More complex
let task2 = URLSession.shared.dataTask(with: url) { data, response, error in
    if let error  = error {
        print("ERROR> \(error)")
        return
    }

    guard let httpResponse = response as? HTTPURLResponse,
          (200...299).contains(httpResponse.statusCode) else {
        print("ERROR> invalid status code")
        return
    }

    guard let data = data else {
        print("ERROR> no data?")
        return
    }

    print("Data>\n\(data)")
    do {
        try JSONDecoder()
            .decode(Course.self, from: data)
            .events
            .map { print("Course: \($0.datetime): \($0.title)") }
    } catch {
        print("ERROR> \(error)")
    }

}

print("Start URL Session")
task2.resume()
