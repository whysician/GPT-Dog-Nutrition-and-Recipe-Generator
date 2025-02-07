//
//  GPT_Dog_Nutrition_and_Recipe_GeneratorApp.swift
//  GPT-Dog-Nutrition-and-Recipe-Generator
//
//  Created by Victoria Sok on 1/29/25.
//

import SwiftUI
import SwiftData

@main
struct GPT_Dog_Nutrition_and_Recipe_GeneratorApp: App {
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
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
