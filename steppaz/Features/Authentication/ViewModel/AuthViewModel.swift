//
//  AuthViewModel.swift
//  steppaz
//
//  Created by Godwin IE on 06/03/2025.
//

import Foundation
import SwiftUI

@MainActor
class AuthViewModel: ObservableObject {
    private let authService = AuthenticationService.shared
    
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    init() {
        Task {
            await fetchCurrentUser()
        }
    }
    
    func fetchCurrentUser() async {
        isLoading = true
        
        currentUser = await authService.getCurrentUser()
        isAuthenticated = currentUser != nil
        
        isLoading = false
    }
    
    func signUp(email: String, password: String, username: String) async {
        await performAuthOperation {
            return try await self.authService.signUpWithEmail(email: email, password: password, username: username)
        }
    }
    
    func signIn(email: String, password: String) async {
        await performAuthOperation {
            return try await self.authService.signInWithEmail(email: email, password: password)
        }
    }
    
    func signOut() async {
        isLoading = true
        do {
            try await authService.signOut()
            isAuthenticated = false
            currentUser = nil
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    private func performAuthOperation(operation: @escaping () async throws -> User) async {
        isLoading = true
        errorMessage = nil
        do {
            let user = try await operation()
            currentUser = user
            isAuthenticated = true
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
