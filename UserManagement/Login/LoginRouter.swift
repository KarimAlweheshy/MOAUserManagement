//
//  LoginRouter.swift
//  ModuleArchitectureDemo
//
//  Created by Mladen Despotovic on 29.06.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import UIKit

protocol LoginRouter {
}

final class LoginDefaultRouter {
    fileprivate unowned let viewController: LoginViewController
    
    init(viewController: LoginViewController) {
        self.viewController = viewController
    }
}

// MARK: - LoginRouter
extension LoginDefaultRouter: LoginRouter {
    
}
