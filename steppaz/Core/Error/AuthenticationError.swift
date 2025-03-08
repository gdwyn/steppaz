//
//  AuthenticationError.swift
//  steppaz
//
//  Created by Godwin IE on 08/03/2025.
//


enum AuthenticationError: Error {
    case signUpFailed(String)
    case signInFailed(String)
    case unknownError
}
