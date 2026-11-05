//
//  WelcomePresenter.swift
//  Bankodemia
//
//  Created by javier pineda on 13/10/26.
//

import Foundation

final class WelcomePresenter {
    private let onShowLogin: () -> Void
    
    init(onShowLogin: @escaping () -> Void) {
        self.onShowLogin = onShowLogin
    }
    
    func showLogintrmps() {
        self.onShowLogin()
    }
}
