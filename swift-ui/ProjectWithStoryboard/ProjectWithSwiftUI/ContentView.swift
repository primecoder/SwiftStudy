//
//  ContentView.swift
//  ProjectWithSwiftUI
//
//  Created by Ace Authors on 26/10/20.
//

import SwiftUI
import Combine

class CourseModel: ObservableObject {
    @Published var course = Course(events: [])
    
    var eventCombineService = EventCombineService()
    
    var cancellable: Cancellable?
    
    func load() {
        cancellable = eventCombineService.fetchData()
            .receive(on: RunLoop.main)
            .sink { (error) in
                print("Done fetch")
            } receiveValue: { (course) in
                self.course = course
            }

    }
}

struct ContentView: View {
    @ObservedObject var courseModel = CourseModel()
        
    var body: some View {
        let events = courseModel.course.events
        let maxItems = events.count
        ScrollView {
            VStack(alignment: .leading) {
                Text("Event count: \(maxItems)")
                ForEach((0..<maxItems), id: \.self) { eventIndex in
                    let event = events[eventIndex]
                    Text(SimpleEventModelView(for: event).eventText)
                        .font(.title2)
                        .fontWeight(.light)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 4.0)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                               maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                               alignment: .leading)
                }
            }
            .padding(.horizontal)
            .background(Color(red: 0.6, green: 0.7, blue: 0.75))
        }
        .onAppear(perform: {
            self.courseModel.load()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
