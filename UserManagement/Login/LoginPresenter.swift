//
//  LoginPresenter.swift
//  ModuleArchitectureDemo
//
//  Created by Mladen Despotovic on 29.06.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation
import Networking

protocol LoginPresenter {
    func didChange(username: String?)
    func didChange(password: String?)
    
    func login()
    func cancel()
}

final class LoginDefaultPresenter {
    fileprivate let resultCallback: ((Result<AuthenticationResponse>) -> Void)?
    fileprivate let router: LoginRouter
    fileprivate let interactor: LoginInteractor
    fileprivate var username: String?
    fileprivate var password: String?
    
    init(resultCallback: ((Result<AuthenticationResponse>) -> Void)?,
         router: LoginRouter, interactor: LoginInteractor,
         username: String?, password: String?) {
        
        self.resultCallback = resultCallback
        self.router = router
        self.interactor = interactor
        self.username = username
        self.password = password
    }
}

// MARK: - LoginPresenter
extension LoginDefaultPresenter: LoginPresenter {
    func didChange(username: String?) { self.username = username }
    func didChange(password: String?) { self.password = password }
    
    func login() {
        guard let username = username, let password = password else { return }
        
//        interactor.getPaymentToken(username: username, password: password) { [weak self] (result) in
//            guard let self = self else { return }
            self.resultCallback?(.success(AuthenticationResponse(authToken: "blabla", refreshToken: "more bla bla")))
//        }
    }
    
    func cancel() {
        resultCallback?(.error(ResponseError.taskCancelled))
    }
}
