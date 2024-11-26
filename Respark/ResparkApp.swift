//
//  ResparkApp.swift
//  Respark
//
//  Created by Mateusz Ficek on 26/11/2024.
//

import SwiftData
import SwiftUI

@main
struct ResparkApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
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
            OnboardingView()
        }
        .modelContainer(sharedModelContainer)
    }
}
