//
//  SwiftUI_CoreData_by_Ace_MacApp.swift
//  SwiftUI-CoreData-by-Ace-Mac
//
//  Created by Ace on 9/8/2023.
//

import SwiftUI

@main
struct SwiftUI_CoreData_by_Ace_MacApp: App {
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
