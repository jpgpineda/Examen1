//
//  WelcomeViewController.swift
//  Bankodemia
//
//  Created by javier pineda on 08/10/26.
//

import UIKit

class WelcomeViewController: UIViewController {
    private let presenter: WelcomePresenter

    init(presenter: WelcomePresenter) {
        self.presenter = presenter
        super.init(nibName: "WelcomeViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func showLogin(_ sender: UIButton) {
        presenter.showLogin()
    }

    @IBAction func showSignUp(_ sender: UIButton) {
        presenter.showSignUp()
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
