//
//  SwiftUI_CoreData_by_AceApp.swift
//  SwiftUI-CoreData-by-Ace
//
//  Created by Ace on 9/8/2023.
//

import SwiftUI

@main
struct SwiftUI_CoreData_by_AceApp: App {
//    let persistenceController = PersistenceController.shared
//    let persistenceController = PersistenceController(inMemory: true)
    let persistenceController = PersistenceController.preview
    
    var body: some Scene {
        let viewContext = persistenceController.container.viewContext
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, viewContext)
        }
    }
}
