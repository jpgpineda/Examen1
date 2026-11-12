//
//  PersonalInfoViewController.swift
//  Bankodemia
//
//  Created by javier pineda on 12/11/26.
//

import UIKit

class PersonalInfoViewController: UIViewController {

    @IBOutlet weak var nametextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var bornDateTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var genreControler: UISegmentedControl!
    @IBOutlet weak var profileImageView: UIImageView!
    private let presenter: PersonalInfoPresenter
    
    init(presenter: PersonalInfoPresenter) {
        self.presenter = presenter
        super.init(nibName: "PersonalInfoViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func openImagePicker(_ sender: UIButton) {
        
    }
    
    @IBAction func requestSave(_ sender: UIButton) {
        presenter.didTapSave(name: nametextField.text ?? "",
                             lastName: lastNameTextField.text ?? "",
                             userName: userNameTextField.text ?? "",
                             phone: phoneTextField.text ?? "",
                             genre: genreControler.selectedSegmentIndex == .zero ? .male : .female)
    }
}

extension PersonalInfoViewController: PersonalView {
    func manageLoader(_ isLoading: Bool) {
        isLoading ? showLoader() : hideLoader()
    }
    
    func showErrorMessage(_ message: String) {
        
    }
    
    func showBirthDate(_ text: String) {
        bornDateTextField.text = text
    }
    
    func showBirthDateError(_ message: String?) {
        
    }
}
