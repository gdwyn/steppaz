//
//  steppaApp.swift
//  steppa
//
//  Created by Godwin IE on 01/03/2025.
//

import SwiftUI

@main
struct steppaApp: App {
    @StateObject private var authViewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            if authViewModel.isAuthenticated {
                MainTabView()
                    .environmentObject(authViewModel)
            } else {
                MainTabView()
                    .environmentObject(authViewModel)
            }
        }
    }
}
