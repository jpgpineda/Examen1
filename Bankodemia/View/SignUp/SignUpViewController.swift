//
//  SignUpViewController.swift
//  Bankodemia
//
//  Created by javier pineda on 24/09/26.
//

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

    private func setupView() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }

    @objc private func textDidChange() {
        presenter.fieldsDidChange(email: emailTextField.text ?? "",
                                  password: passwordTextField.text ?? "")
    }

    @IBAction func requestSignUp(_ sender: UIButton) {
        view.endEditing(true)
        presenter.requestSignUp(email: emailTextField.text ?? "",
                                password: passwordTextField.text ?? "")
    }

    @IBAction func goBack(_ sender: UIButton) {
        presenter.goBack()
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

    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


