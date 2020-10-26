//
//  SimpleEventModelView.swift
//  ProjectWithStoryboard
//
//  Created by Ace Authors on 26/10/20.
//

import Foundation

struct SimpleEventModelView {
    let event: Event
    
    let inputDateFormatter = DateFormatter()
    let shortDateFormatter = DateFormatter()
    
    var eventText: String {
        let eventTime = inputDateFormatter.date(from: event.datetime)
        let dateStr = (eventTime != nil) ? shortDateFormatter.string(from: eventTime!) : "(n/a)"
        return "\(dateStr) \(event.title)"
    }
    
    init(for event: Event) {
        self.event = event
        self.inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        self.shortDateFormatter.dateFormat = "EEE dd MMM yy"
    }
}
