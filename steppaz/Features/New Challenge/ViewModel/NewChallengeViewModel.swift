//
//  NewChallengeViewModel.swift
//  steppaz
//
//  Created by Godwin IE on 07/03/2025.
//

import Foundation
import Supabase

class NewChallengeViewModel: ObservableObject {
    @Published var title = ""
    @Published var description = ""
    @Published var targetSteps = 5000
    @Published var duration = 7
    @Published var startDate = Date()
    @Published var selectedFriends: [User] = []
    @Published var isLoading = false
    @Published var error: Error?
    @Published var friends: [User] = []
    
    private let supabase = SupabaseClient.shared
    
    func createChallenge() async -> Bool {
        guard !title.isEmpty, targetSteps > 0, duration > 0 else {
            return false
        }
        
        isLoading = true
        
        do {
            let userId = AuthService.shared.currentUser?.id ?? ""
            let endDate = Calendar.current.date(byAdding: .day, value: duration, to: startDate)!
            
            let participantIds = [userId] + selectedFriends.map { $0.id }
            
            let challenge = Challenge(
                id: UUID().uuidString,
                creatorId: userId,
                title: title,
                description: description,
                targetSteps: targetSteps,
                duration: duration,
                startDate: startDate,
                endDate: endDate,
                participantIds: participantIds,
                status: .active
            )
            
            try await supabase
                .from("challenges")
                .insert(challenge)
                .execute()
            
            // Create notifications for friends
            for friendId in selectedFriends.map({ $0.id }) {
                try await supabase
                    .from("notifications")
                    .insert([
                        "user_id": friendId,
                        "type": "challenge_invite",
                        "title": "New Challenge Invitation",
                        "body": "\(AuthService.shared.currentUser?.username ?? "Someone") invited you to \(title)",
                        "data": ["challenge_id": challenge.id]
                    ])
                    .execute()
            }
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
            return true
        } catch {
            DispatchQueue.main.async {
                self.error = error
                self.isLoading = false
            }
            return false
        }
    }
    
    func fetchFriends() async {
        // Implementation to fetch user's friends from Supabase
    }
}
