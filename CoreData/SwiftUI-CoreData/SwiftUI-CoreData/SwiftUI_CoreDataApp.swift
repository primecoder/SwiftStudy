//
//  SwiftUI_CoreDataApp.swift
//  SwiftUI-CoreData
//
//  Created by Ace on 9/8/2023.
//

import SwiftUI

@main
struct SwiftUI_CoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
