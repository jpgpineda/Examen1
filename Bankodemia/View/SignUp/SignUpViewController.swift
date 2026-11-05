//
//  SignUpViewController.swift
//  Bankodemia
//
//  Created by javier pineda on 24/09/26.
//
// Comentario para primer commit abigail

import UIKit

class SignUpViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var backTopButton: UIButton!
    
    
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    var presenter: SignUpPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        passwordTextField.isSecureTextEntry = true
        
        
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        
        
        updateRegisterButton(isEnabled: false)
        registerButton.layer.cornerRadius = 6
        
        
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange() {
        
        presenter?.validateForm(email: emailTextField.text, password: passwordTextField.text)
    }

    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        presenter?.registerTapped(email: emailTextField.text, password: passwordTextField.text)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        presenter?.backTapped()
    }
}

extension SignUpViewController: SignUpViewProtocol {
    
    func updateRegisterButton(isEnabled: Bool) {
        registerButton.isEnabled = isEnabled
        registerButton.backgroundColor = isEnabled ? .systemBlue : .systemGray4
    }
    
    func showEmailError(_ message: String?) {
        if let error = message {
            emailErrorLabel.text = error
            emailErrorLabel.isHidden = false
            emailTextField.layer.borderColor = UIColor.systemRed.cgColor
            emailTextField.layer.borderWidth = 1
        } else {
            emailErrorLabel.isHidden = true
            emailTextField.layer.borderWidth = 0
        }
    }
    
    func showPasswordError(_ message: String?) {
        if let error = message {
            passwordErrorLabel.text = error
            passwordErrorLabel.isHidden = false
            passwordTextField.layer.borderColor = UIColor.systemRed.cgColor
            passwordTextField.layer.borderWidth = 1
        } else {
            passwordErrorLabel.isHidden = true
            passwordTextField.layer.borderWidth = 0
        }
    }
    
    func showLoading(_ isVisible: Bool) {
        
        view.isUserInteractionEnabled = !isVisible
        registerButton.setTitle(isVisible ? "Cargando..." : "Registrarse", for: .normal)
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
        present(alert, animated: true)
    }
}
