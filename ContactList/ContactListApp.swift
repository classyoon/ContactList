//
//  ContactListApp.swift
//  ContactList
//
//  Created by Conner Yoon on 5/27/24.
//

import SwiftUI
import SwiftData

@main
struct ContactListApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([Person.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            PersonListView()
        }
        .modelContainer(sharedModelContainer)
    }
}
