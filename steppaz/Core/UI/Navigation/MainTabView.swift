//
//  MainTabView.swift
//  steppaz
//
//  Created by Godwin IE on 07/03/2025.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var homeViewModel = HomeViewModel()
//    @StateObject private var exploreViewModel = ExploreViewModel()
//    @StateObject private var leaderboardViewModel = LeaderboardViewModel()
//    @StateObject private var historyViewModel = HistoryViewModel()
    
    var body: some View {
        TabView {
            HomeView()
                .environmentObject(homeViewModel)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            HomeView()
                .environmentObject(homeViewModel)
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }
            
            HomeView()
                .environmentObject(homeViewModel)
                .tabItem {
                    Label("Leaderboard", systemImage: "chart.bar")
                }
            
            HomeView()
                .environmentObject(homeViewModel)
                .tabItem {
                    Label("History", systemImage: "clock")
                }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
//                NavigationLink(destination: ProfileView()) {
//                    ProfileAvatarView()
//                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                   // PointsView()
                    
                    Button(action: {
                        // Present new challenge sheet
                    }) {
                        Text("New Challenge")
                            .fontWeight(.medium)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }
}

#Preview {
    MainTabView()
}
