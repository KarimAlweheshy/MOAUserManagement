//
//  LoginViewController.swift
//  ModuleArchitectureDemo
//
//  Created by Mladen Despotovic on 29.06.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation
import UIKit

final class LoginViewController: UIViewController {
    
    var presenter: LoginPresenter!
    
    @IBOutlet fileprivate var usernameField: UITextField!
    @IBOutlet fileprivate var passwordField: UITextField!
}

// MARK: - Actions
extension LoginViewController {
    @IBAction fileprivate func login() {
        presenter.login()
    }
    
    @IBAction fileprivate func dismiss() {
        presenter.cancel()
    }
    
    @IBAction fileprivate func textChanged(_ textField: UITextField) {
        if textField == usernameField {
            presenter.didChange(username: textField.text)
        } else if textField == passwordField {
            presenter.didChange(password: textField.text)
        }
    }
}
