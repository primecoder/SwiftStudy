/*
 This JSON data structure is part of my screensaver dashboard project.
 Events server is located on my Pi-one server running simple python + flask.
 It can be accessed as follow.

 $ curl http://pi-one:5000/events/api/v1.0/mock

 Data structure is as follow:

 {
    "events": [
        { "datetime": "2020-10-04 00:00", "title": "Daylight Saving Starts" },
        { "datetime": "2021-01-07 00:00", "title": "Cathy's birthday" },
        ...
    ]
 }

 JSON -> Model:

 Created using app.quicktype.io

 This file was generated from JSON Schema using quicktype, do not modify it directly.
 To parse the JSON, add this file to your project and do:

   let events = try? newJSONDecoder().decode(Events.self, from: jsonData)

*/


import Foundation

// MARK: - Course

/// Course of events
/// To be able to share with pages in playground, 'public' keyword must be declared.
public struct Course: Codable {
    public let events: [Event]
}

// MARK: - Event

/// Represent individual event.
/// To be able to share with pages in playground, 'public' keyword must be declared.
public struct Event: Codable {
    public let datetime: String
    public let title: String
}
