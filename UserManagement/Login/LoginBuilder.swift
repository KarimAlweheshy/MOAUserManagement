//
//  LoginBuilder.swift
//  UserManagement
//
//  Created by Karim Alweheshy on 2/7/19.
//  Copyright © 2019 Karim Alweheshy. All rights reserved.
//

import UIKit
import Networking

final class LoginBuilder: NSObject {
    static func make(networking: NetworkingType, loginData: ExplicitLoginRequestBody,
                     resultCallback: @escaping (Result<AuthenticationResponse>) -> Void) -> LoginViewController {
        let storyboard = UIStoryboard(name: "Login", bundle: Bundle(for: self))
        let viewController = storyboard.instantiateInitialViewController() as! LoginViewController
        let router = LoginDefaultRouter(viewController: viewController)
        let interactor = LoginDefaultInteractor(networking: networking)
        let presenter = LoginDefaultPresenter(resultCallback: resultCallback, router: router,
                                              interactor: interactor, username: loginData.email,
                                              password: loginData.password)
        viewController.presenter = presenter
        return viewController
    }
}
