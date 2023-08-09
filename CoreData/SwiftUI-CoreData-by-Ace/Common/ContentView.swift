//
//  ContentView.swift
//  SwiftUI-CoreData-by-Ace-Mac
//
//  Created by Ace on 9/8/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Event.beginDate, ascending: true)],
        animation: .default
    )
    private var events: FetchedResults<Event>
    
    var body: some View {
        List {
            ForEach(events) { event in
                Text("Event \(event.name!)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
