//
//  UserProfile.swift
//  Bankodemia
//
//  Created by javier pineda on 12/11/26.
//

import Foundation

struct UserProfile: Equatable {
    let id: String
    let name: String
    let email: String
    let lastName: String
    let userName: String
    let phone: String
    let bornDate: Date
    let genre: UserGenre
}

enum UserGenre: String, Codable {
    case male, female
}

enum UserRepositoryError: LocalizedError {
    case saveFailed, loadFailed
    
    var errorDescription: String? {
        switch self {
        case .saveFailed:
            return "Failed to save user"
        case .loadFailed:
            return "Failed to load user"
        }
    }
}
