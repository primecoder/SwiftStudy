import Foundation

// Put in top-level Sources folder to share between pages.
// But, damn!, to make my Xcode Playground recompile, I had to quit and restart Xcode
// each time!!! :-(
// [aa-20201023]
//    |
//    +-- This seemed to be fixed now in Xcode 14.3.1 [aa-20230719]
//        With Xcode 14.3.1, changes take affect straight away.

// MARK: - Review
// Created using app.quicktype.io
// To be able to share with pages in playground, 'public' keyword must be declared.
public struct Review: Codable {
    public let text: String
    public let label: Label
}

public enum Label: String, Codable {
    case negative = "negative"
    case neutral = "neutral"
    case positive = "positive"
}

public typealias Reviews = [Review]
