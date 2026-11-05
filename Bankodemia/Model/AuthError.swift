//
//  AuthError.swift
//  Bankodemia
//
//  Created by Javier OnTop on 03/11/26.
//

import Foundation

enum AuthError: LocalizedError {
    case invalidCredentials
    case emailAlreadyInUse
    case network
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Invalid credentials"
        case .network:
            return "Network error"
        case .unknown:
            return "Unknown error"
        case .emailAlreadyInUse:
            return "Email already in use"
        }
    }
}
