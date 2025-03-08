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
        // Nice try 👀
        let supabaseURL = URL(string: "YOUR_SUPABASE_URL")!
        let supabaseKey = "YOUR_SUPABASE_API_KEY"
        
        self.client = Supabase.SupabaseClient(
            supabaseURL: supabaseURL,
            supabaseKey: supabaseKey
        )
    }
}
