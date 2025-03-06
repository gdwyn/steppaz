//
//  A.swift
//  steppaz
//
//  Created by Godwin IE on 06/03/2025.
//

import Swift
import Supabase

class AuthService {
    static let shared = AuthenticationService()
    private let supabase = SupabaseClient(
        supabaseURL: URL(string: "YOUR_SUPABASE_URL")!,
        supabaseKey: "YOUR_SUPABASE_API_KEY"
    )
    
    var currentUser: User? {
        supabase.auth.session?.user
    }
    
    func signUpWithEmail(email: String, password: String) async throws -> User {
        let response = try await supabase.auth.signUp(
            email: email,
            password: password
        )
        return response.user
    }
    
    func signInWithEmail(email: String, password: String) async throws -> User {
        let response = try await supabase.auth.signIn(
            email: email,
            password: password
        )
        return response.user
    }
    
    func signInWithApple(idToken: String) async throws -> User {
        let response = try await supabase.auth.signInWithIdToken(
            credentials: .init(provider: .apple, idToken: idToken)
        )
        return response.user
    }
    
    func signInWithGoogle(idToken: String) async throws -> User {
        let response = try await supabase.auth.signInWithIdToken(
            credentials: .init(provider: .google, idToken: idToken)
        )
        return response.user
    }
    
    func signOut() async throws {
        try await supabase.auth.signOut()
    }
}
