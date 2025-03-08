////
////  LeaderboardViewModel.swift
////  steppaz
////
////  Created by Godwin IE on 07/03/2025.
////
//
//import Foundation
//
//class LeaderboardViewModel: ObservableObject {
//    @Published var leaderboardEntries: [LeaderboardEntry] = []
//    @Published var selectedChallenge: Challenge?
//    @Published var userChallenges: [Challenge] = []
//    @Published var isLoading = false
//    @Published var error: Error?
//    
//    private let supabase = SupabaseClient.shared
//    
////    struct LeaderboardEntry: Identifiable {
////        let id: String
////        let userId: String
////        let username: String
////        let avatarUrl: String?
////        let totalSteps: Int
////        let rank: Int
////        let isCurrentUser: Bool
////    }
//    
//    func fetchUserChallenges() async {
//        // Fetches challenges the user is part of
//    }
//    
//    func fetchLeaderboard(for challengeId: String) async {
//        isLoading = true
//        
//        do {
//            // Get all progress for this challenge
//            let progress = try await supabase
//                .from("daily_progress")
//                .select("""
//                user_id, SUM(steps) as total_steps
//                """)
//                .eq("challenge_id", challengeId)
//                .group("user_id")
//                .execute()
//                .value as [[String: Any]]
//            
//            // Get user details
//            let userIds = progress.compactMap { $0["user_id"] as? String }
//            let users = try await supabase
//                .from("users")
//                .select()
//                .in("id", userIds)
//                .execute()
//                .value as [[String: Any]]
//            
//            // Combine data and sort
//            var entries: [LeaderboardEntry] = []
//            
//            for (index, entry) in progress.enumerated() {
//                guard 
//                    let userId = entry["user_id"] as? String,
//                    let totalSteps = entry["total_steps"] as? Int
//                else { continue }
//                
//                let user = users.first { ($0["id"] as? String) == userId }
//                let username = user?["username"] as? String ?? "Unknown"
//                let avatarUrl = user?["avatar_url"] as? String
//                
//                let leaderboardEntry = LeaderboardEntry(
//                    id: UUID().uuidString,
//                    userId: userId,
//                    username: username,
//                    avatarUrl: avatarUrl,
//                    totalSteps: totalSteps,
//                    rank: index + 1,
//                    isCurrentUser: userId == AuthenticationService.shared.currentUser?.id
//                )
//                
//                entries.append(leaderboardEntry)
//            }
//            
//            // Sort by steps
//            entries.sort { $0.totalSteps > $1.totalSteps }
//            
//            // Update ranks
//            for i in 0..<entries.count {
//                entries[i].rank = i + 1
//            }
//            
//            DispatchQueue.main.async {
//                self.leaderboardEntries = entries
//                self.isLoading = false
//            }
//        } catch {
//            DispatchQueue.main.async {
//                self.error = error
//                self.isLoading = false
//            }
//        }
//    }
//}
