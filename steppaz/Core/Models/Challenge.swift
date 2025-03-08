//
//  Challenge.swift
//  steppaz
//
//  Created by Godwin IE on 07/03/2025.
//

import SwiftUI

struct Challenge: Identifiable, Codable {
    let id: String
    let creatorId: String
    let title: String
    let description: String
    let targetSteps: Int
    let duration: Int // in days
    let startDate: Date
    let endDate: Date
    var participantIds: [String]
    var status: ChallengeStatus
    
    enum ChallengeStatus: String, Codable {
        case active, completed, cancelled
    }
}
