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
    case weakPassword
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Credenciales incorrectas"
        case .network:
            return "Error de conexión"
        case .unknown:
            return "Ocurrió un error inesperado"
        case .emailAlreadyInUse:
            return "El correo ya está en uso"
        case .weakPassword:
            return "La contraseña debe tener al menos 6 caracteres"
        }
    }
}
