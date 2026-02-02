//
//  ClasslyApp.swift
//  Classly
//
//  Created by Jacob Silva on 2/1/26.
//

import SwiftUI
import CoreData

@main
struct ClasslyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
