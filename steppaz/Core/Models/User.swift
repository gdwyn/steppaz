//
//  User.swift
//  steppaz
//
//  Created by Godwin IE on 07/03/2025.
//


struct User: Identifiable, Codable {
    let id: String
    let email: String?
    let username: String?
    var points: Int
    var totalSteps: Int
}
