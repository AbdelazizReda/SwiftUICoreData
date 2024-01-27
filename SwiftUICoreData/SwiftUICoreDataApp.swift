//
//  SwiftUICoreDataApp.swift
//  SwiftUICoreData
//
//  Created by Abdelaziz Reda on 27/01/2024.
//

import SwiftUI

@main
struct SwiftUICoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
