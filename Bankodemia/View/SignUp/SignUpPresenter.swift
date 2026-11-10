//
//  SignUpPresenter.swift
//  Bankodemia
//
//  Created by javier pineda on 05/11/26.
//

import Foundation

protocol SignUpView: AnyObject {
    func showEmailError(message: String?)
    func showPasswordError(message: String?)
    func setSignUpButtonEnabled(_ isEnabled: Bool)
    func manageLoader(_ isLoading: Bool)
}

final class SignUpPresenter {
    weak var view: SignUpView?
    private let onSignUpSuccess: () -> Void
    private let onBack: () -> Void
    private let validator: LoginValidatorProtocol
    private let authRepository: AuthRepositoryProtocol
    
    init(onSignUpSuccess: @escaping () -> Void,
         onBack: @escaping () -> Void,
         validator: LoginValidatorProtocol,
         authRepository: AuthRepositoryProtocol) {
        self.onSignUpSuccess = onSignUpSuccess
        self.onBack = onBack
        self.validator = validator
        self.authRepository = authRepository
    }
    
    func emailDidEndEditing(_ email: String) {
        view?.showEmailError(message: validator.validateEmail(email)?.message)
    }
    
    func passwordDidEndEditing(_ password: String) {
        view?.showPasswordError(message: validator.validatePassword(password)?.message)
    }
    
    func fieldsDidChange(email: String, password: String) {
        let isFormValid = validator.validateEmail(email) == nil && validator.validatePassword(password) == nil
        view?.setSignUpButtonEnabled(isFormValid)
    }
    
    func requestSignUp(email: String, password: String) {
        view?.manageLoader(true)
        Task { @MainActor [weak self] in
            guard let self = self else { return }
            do {
                let _ = try await self.authRepository.signUp(email: email, password: password)
                self.view?.manageLoader(false)
                self.onSignUpSuccess()
            } catch {
                self.view?.manageLoader(false)
                self.view?.showEmailError(message: error.localizedDescription)
            }
        }
    }
    
    func goBack() {
        onBack()
    }
}
