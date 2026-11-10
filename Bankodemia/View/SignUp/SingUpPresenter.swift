//
//  SignUpPresenter.swift
//  Bankodemia
//
//  Created by Origenes Bordados on 10/11/26.
//

import Foundation

protocol SignUpView: AnyObject {
    func showEmailError(message: String?)
    func showPasswordError(message: String?)
    func setSignUpButtonEnabled(_ isEnabled: Bool)
    func manageLoader(_ isLoading: Bool)
    func showFirebaseError(message: String)
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
                _ = try await self.authRepository.signUp(email: email, password: password)
                self.view?.manageLoader(false)
                self.onSignUpSuccess()
            } catch let authError as AuthError {
                self.view?.manageLoader(false)
                self.view?.showFirebaseError(message: authError.errorDescription ?? "Error desconocido")
            } catch {
                self.view?.manageLoader(false)
                self.view?.showFirebaseError(message: error.localizedDescription)
            }
        }
    }

    func goBack() {
        onBack()
    }
}
