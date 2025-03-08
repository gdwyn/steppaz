//
//  SupabaseClient.swift
//  steppaz
//
//  Created by Godwin IE on 07/03/2025.
//

import Foundation
import Supabase

class SupabaseClient {
    static let shared = SupabaseClient()

    let client: Supabase.SupabaseClient

    private init() {
        guard let supabaseURL = URL(string: "https://your-project-ref.supabase.co") else {
            fatalError("Invalid Supabase URL")
        }

        let supabaseKey = "your-anon-key"

        self.client = Supabase.SupabaseClient(supabaseURL: supabaseURL, supabaseKey: supabaseKey)
    }
}
