//
//  DailyProgress.swift
//  steppaz
//
//  Created by Godwin IE on 07/03/2025.
//

import SwiftUI

struct DailyProgress: Identifiable, Codable {
    let id: String
    let userId: String
    let challengeId: String
    let date: Date
    let steps: Int
    let completed: Bool
}
