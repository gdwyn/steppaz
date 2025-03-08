//
//  HomeViewModel.swift
//  steppaz
//
//  Created by Godwin IE on 06/03/2025.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var activeChallenges: [Challenge] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let supabase = SupabaseClient.shared.client

    func fetchActiveChallenges() async {
        isLoading = true
        errorMessage = nil

        do {
            guard let userId = await AuthenticationService.shared.getCurrentUser()?.id else {
                throw NSError(domain: "HomeViewModel", code: 1, userInfo: [NSLocalizedDescriptionKey: "User not found"])
            }

            let challenges: [Challenge] = try await supabase
                .from("challenges")
                .select()
                .contains("participant_ids", value: userId)
                .eq("status", value: "active")
                .execute()
                .value

            activeChallenges = challenges
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
