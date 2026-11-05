//
//  LoginPresenter.swift
//  Bankodemia
//
//  Created by javier pineda on 13/10/26.
//

import Foundation

protocol LoginView: AnyObject {
    func showEmailErrortrmps(message: String?)
    func showPasswordErrortrmps(message: String?)
    func setLoginButtonEnabledtrmps(_ isEnabled: Bool)
    func manageLoadertrmps(_ isLoading: Bool)
}

final class LoginPresenter {
    weak var view: LoginView?
    private let onLoginSuccess: () -> Void
    private let validator: LoginValidatorProtocol
    private let authRepository: AuthRepositoryProtocol
    
    init(onLoginSuccess: @escaping () -> Void,
         validator: LoginValidatorProtocol,
         authRepository: AuthRepositoryProtocol) {
        self.onLoginSuccess = onLoginSuccess
        self.validator = validator
        self.authRepository = authRepository
    }
    
    func emailDidEndEditingtrmps(_ email: String) {
        view?.showEmailErrortrmps(message: validator.validateEmailtrmps(email)?.message)
    }
    
    func passwordDidEndEditingtrmps(_ password: String) {
        view?.showPasswordErrortrmps(message: validator.validatePasswordtrmps(password)?.message)
    }
    
    func fieldsDidChangetrmps(email: String, password: String) {
        let isFormValid = validator.validateEmailtrmps(email) == nil && validator.validatePasswordtrmps(password) == nil
        view?.setLoginButtonEnabledtrmps(isFormValid)
    }
    
    func requestLogintrmps(email: String, password: String) {
        view?.manageLoadertrmps(true)
        Task { @MainActor [weak self] in
            guard let self = self else { return }
            do {
                let user = try await self.authRepository.signUp(email: email, password: password)
                self.view?.manageLoadertrmps(false)
                self.onLoginSuccess()
            } catch {
                self.view?.manageLoadertrmps(false)
                self.view?.showEmailErrortrmps(message: error.localizedDescription)
            }
        }
    }
}
