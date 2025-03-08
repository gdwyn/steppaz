//
//  HomeView.swift
//  steppaz
//
//  Created by Godwin IE on 06/03/2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @State private var showingNewChallengeSheet = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Daily progress summary
                    Text("progress")
                    //DailyProgressCard()
                    
                    // Active challenges
                    Text("Active Challenges")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    } else if viewModel.activeChallenges.isEmpty {
                        EmptyView()
//                        EmptyStateView(
//                            title: "No Active Challenges",
//                            message: "Start a new challenge or join one from the Explore tab.",
//                            buttonTitle: "Create Challenge",
//                            action: { showingNewChallengeSheet = true }
//                        )
                    } else {
                        ForEach(viewModel.activeChallenges) { challenge in
                            //ChallengeCard(challenge: challenge)
                               // .padding(.horizontal)
                            Text(challenge.title)

                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Home")
            .refreshable {
                await viewModel.fetchActiveChallenges()
            }
            .onAppear {
                Task {
                    await viewModel.fetchActiveChallenges()
                }
            }
            .sheet(isPresented: $showingNewChallengeSheet) {
                // NewChallengeView()
            }
        }
    }
}

#Preview {
    HomeView()
}
