//
//  LoginValidator.swift
//  Bankodemia
//
//  Created by javier pineda on 20/10/26.
//

import Foundation

enum ValidationError: Equatable {
    case empty
    case invalidFormat
    case tooShort(min: Int)
    
    var message: String {
        switch self {
        case .empty:
            return "Este campo es obligatorio"
        case .invalidFormat:
            return "El formato no es válido"
        case .tooShort(min: let min):
            return "Debe tener al menos \(min) caracteres"
        }
    }
}

protocol LoginValidatorProtocol {
    func validateEmail(_ email: String) -> ValidationError?
    func validatePassword(_ password: String) -> ValidationError?
}

struct LoginValidator: LoginValidatorProtocol {
    private let minPasswordLength: Int = 6
    
    func validateEmail(_ email: String) -> ValidationError? {
        let trimmed = email.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return .empty }
        
        let pattern = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let isValid = trimmed.range(of: pattern, options: .regularExpression) != nil
        return isValid ? nil : .invalidFormat
    }
    
    func validatePassword(_ password: String) -> ValidationError? {
        guard !password.isEmpty else { return .empty }
        return password.count < minPasswordLength ? .tooShort(min: minPasswordLength) : nil
    }
}
