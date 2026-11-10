//
//  SignUpViewController.swift
//  Bankodemia
//
//  Created by javier pineda on 24/09/26.
//
// Comentario para primer commit abigail

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    private let presenter: SignUpPresenter
    
    init(presenter: SignUpPresenter) {
        self.presenter = presenter
        super.init(nibName: "SignUpViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        signUpButton.isEnabled = false
        
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
    }
    
    @objc private func textDidChange() {
        presenter.fieldsDidChange(email: emailTextField.text ?? "",
                                      password: passwordTextField.text ?? "")
    }
    
    @IBAction func requestSignUp(_ sender: UIButton) {
        presenter.requestSignUp(email: emailTextField.text ?? "",
                                     password: passwordTextField.text ?? "")
    }
    
    @IBAction func returnToWelcome(_ sender: UIButton) {
        presenter.returnToWelcome()
    }
}

extension SignUpViewController: SignUpView {
    func showEmailError(message: String?) {
        emailErrorLabel.text = message
        emailErrorLabel.isHidden = message == nil
    }
    
    func showPasswordError(message: String?) {
        passwordErrorLabel.text = message
        passwordErrorLabel.isHidden = message == nil
    }
    
    func setSignUpButtonEnabled(_ isEnabled: Bool) {
        signUpButton.isEnabled = isEnabled
    }
    
    func manageLoader(_ isLoading: Bool) {
        isLoading ? showLoader() : hideLoader()
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            presenter.emailDidEndEditing(textField.text ?? "")
        } else if textField == passwordTextField {
            presenter.passwordDidEndEditing(textField.text ?? "")
        }
    }
}

