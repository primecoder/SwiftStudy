//
//  SwiftUI_CoreData_MacAppApp.swift
//  SwiftUI-CoreData-MacApp
//
//  Created by Ace on 9/8/2023.
//

import SwiftUI

@main
struct SwiftUI_CoreData_MacAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
