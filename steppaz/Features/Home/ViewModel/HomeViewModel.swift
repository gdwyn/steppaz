//
//  HomeViewModel.swift
//  steppaz
//
//  Created by Godwin IE on 06/03/2025.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var activeChallenges: [Challenge] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    private let supabase = SupabaseClient.shared
    
    func fetchActiveChallenges() async {
        isLoading = true
        
       // do {
            let userId = AuthService.shared.currentUser?.id ?? ""
            
            let challenges = supabase
                .from("challenges")
                .select()
                .contains("participant_ids", [userId])
                .eq("status", "active")
                .execute()
                .value
            
            DispatchQueue.main.async {
                self.activeChallenges = challenges
                self.isLoading = false
            }
//        } catch {
//            DispatchQueue.main.async {
//                self.error = error
//                self.isLoading = false
//            }
//        }
    }
}
