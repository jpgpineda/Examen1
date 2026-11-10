//
//  SignUpPresenter.swift
//  Bankodemia
//
//  Created by MacBook 6 on 05/11/26.
//

import Foundation

protocol SignUpView: AnyObject {
    func showEmailError(message: String?)
    func showPasswordError(message: String?)
    func setRegisterButtonEnabled(_ isEnabled: Bool)
    func manageLoader(_ isLoading: Bool)
}

final class SignUpPresenter {
    
    weak var view: SignUpView?
    
    private let onSignUpSuccess: () -> Void
    private let validator: LoginValidatorProtocol
    private let authRepository: AuthRepositoryProtocol
    
    init(onSignUpSuccess: @escaping () -> Void,
         validator: LoginValidatorProtocol,
         authRepository: AuthRepositoryProtocol) {
        
        self.onSignUpSuccess = onSignUpSuccess
        self.validator = validator
        self.authRepository = authRepository
    }
    
    func fieldsDidChange(email: String, password: String) {
        let isValid = validator.validateEmail(email) == nil &&
                      validator.validatePassword(password) == nil
        
        view?.setRegisterButtonEnabled(isValid)
    }
    
    func requestSignUp(email: String, password: String) {
        view?.manageLoader(true)
        
        Task { @MainActor [weak self] in
            guard let self = self else { return }
            
            do {
                _ = try await self.authRepository.signUp(email: email, password: password)
                self.view?.manageLoader(false)
                self.onSignUpSuccess()
            } catch {
                self.view?.manageLoader(false)
                self.view?.showEmailError(message: error.localizedDescription)
            }
        }
    }
}

