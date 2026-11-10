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
    case invalidEmail
    case weakPassword
    case operationNotAllowed
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Credenciales inválidas. Revisa tu correo y contraseña."
        case .network:
            return "Error de red. Revisa tu conexión a internet."
        case .unknown:
            return "Ocurrió un error inesperado. Intenta de nuevo."
        case .emailAlreadyInUse:
            return "Ese correo ya está registrado. Intenta iniciar sesión."
        case .invalidEmail:
            return "El correo no tiene un formato válido."
        case .weakPassword:
            return "La contraseña es demasiado débil."
        case .operationNotAllowed:
            return "El registro con correo y contraseña no está habilitado en Firebase."
        }
    }
}
