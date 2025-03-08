//
//  SniffServeApp.swift
//  SniffServe
//
//  Created by Victoria Sok on 1/29/25.
//

import SwiftUI

@main
struct SniffServeApp: App {
    @State var showLaunchView: Bool = true
    @StateObject var dogViewModel = DogViewModel()

    var body: some Scene {
        WindowGroup {
            ZStack {
                PetListView()
                
                if showLaunchView {
                    LaunchView(showLaunchView: $showLaunchView)
                        .transition(.move(edge: .leading))
                }
            }
            .environmentObject(dogViewModel)
        }
    }
}
