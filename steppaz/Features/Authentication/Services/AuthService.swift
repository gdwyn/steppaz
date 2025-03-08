//
//  A.swift
//  steppaz
//
//  Created by Godwin IE on 06/03/2025.
//

import Foundation
import Supabase

@MainActor
class AuthenticationService {
    static let shared = AuthenticationService()
    private let supabase = SupabaseClient.shared.client
    
    func getCurrentUser() async -> User? {
        do {
            guard let authUser = try? await supabase.auth.user() else { return nil }
            
            let users: [User] = try await supabase
                .from("users")
                .select()
                .eq("id", value: authUser.id.uuidString)
                .limit(1)
                .execute()
                .value
            
            return users.first
        } catch {
            print("Failed to fetch current user:", error.localizedDescription)
            return nil
        }
    }
    
    func signUpWithEmail(email: String, password: String, username: String) async throws -> User {
        let response = try await supabase.auth.signUp(email: email, password: password)
        let authUser = response.user
        
        let newUser = User(id: authUser.id.uuidString, email: authUser.email, username: username, points: 0, totalSteps: 0)
        
        try await supabase
            .from("users")
            .insert(newUser)
            .execute()
        
        return newUser
    }
    
    func signInWithEmail(email: String, password: String) async throws -> User {
        let response = try await supabase.auth.signIn(email: email, password: password)
        let authUser = response.user
        
        let users: [User] = try await supabase
            .from("users")
            .select()
            .eq("id", value: authUser.id.uuidString)
            .limit(1)
            .execute()
            .value
        
        guard let user = users.first else {
            throw AuthenticationError.signInFailed("User not found in database.")
        }
        
        return user
    }
    
    func signInWithApple(idToken: String) async throws -> User {
        let response = try await supabase.auth.signInWithIdToken(credentials: .init(provider: .apple, idToken: idToken))
        let authUser = response.user
        
        let users: [User] = try await supabase
            .from("users")
            .select()
            .eq("id", value: authUser.id.uuidString)
            .limit(1)
            .execute()
            .value
        
        guard let user = users.first else {
            throw AuthenticationError.signInFailed("User not found in database.")
        }
        
        return user
    }
    
    func signInWithGoogle(idToken: String) async throws -> User {
        let response = try await supabase.auth.signInWithIdToken(credentials: .init(provider: .google, idToken: idToken))
        let authUser = response.user
        
        let users: [User] = try await supabase
            .from("users")
            .select()
            .eq("id", value: authUser.id.uuidString)
            .limit(1)
            .execute()
            .value
        
        guard let user = users.first else {
            throw AuthenticationError.signInFailed("User not found in database.")
        }
        
        return user
    }
    
    func signOut() async throws {
        try await supabase.auth.signOut()
    }
}

