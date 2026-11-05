//
//  SignUpPresenter.swift
//  Bankodemia
//
//  Created by Macbook Air 5 on 05/11/26.
//

import Foundation



protocol SignUpViewProtocol: AnyObject {
    func updateRegisterButton(isEnabled: Bool)
    func showEmailError(_ message: String?)
    func showPasswordError(_ message: String?)
    func showLoading(_ isVisible: Bool)
    func showErrorAlert(message: String)
}

protocol SignUpPresenterProtocol {
    func validateForm(email: String?, password: String?)
    func registerTapped(email: String?, password: String?)
    func backTapped()
}

protocol SignUpCoordinatorDelegate: AnyObject {
    func didTapBackToWelcome()
    func didRegisterSuccessfully()
}


class SignUpPresenter: SignUpPresenterProtocol {
    private weak var view: SignUpViewProtocol?
    // private let validator: LoginValidatorProtocol
    // private let authRepository: AuthRepositoryProtocol
    private weak var coordinator: SignUpCoordinatorDelegate?
    
    init(view: SignUpViewProtocol,
         /* validator: LoginValidatorProtocol, */
         /* authRepository: AuthRepositoryProtocol, */
         coordinator: SignUpCoordinatorDelegate) {
        self.view = view
        // self.validator = validator
        // self.authRepository = authRepository
        self.coordinator = coordinator
    }
    
    func validateForm(email: String?, password: String?) {
        
    }
    
    func registerTapped(email: String?, password: String?) {
    
    }
    
    func backTapped() {
        coordinator?.didTapBackToWelcome()
    }
}
