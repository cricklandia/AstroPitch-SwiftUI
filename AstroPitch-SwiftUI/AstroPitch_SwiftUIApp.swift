//
//  AstroPitch_SwiftUIApp.swift
//  AstroPitch-SwiftUI
//
//  Created by Christopher Strickland on 6/29/22.
//

import SwiftUI

@main
struct AstroPitch_SwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
