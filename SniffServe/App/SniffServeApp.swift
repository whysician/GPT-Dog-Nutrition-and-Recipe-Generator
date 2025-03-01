//
//  SniffServeApp.swift
//  SniffServe
//
//  Created by Victoria Sok on 1/29/25.
//

import SwiftUI
import SwiftData

@main
struct SniffServeApp: App {
    @State var showLaunchView: Bool = true
    @StateObject var dogViewModel = DogViewModel()
    
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
            ZStack {
                PetListView()
                    .environmentObject(dogViewModel)
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
