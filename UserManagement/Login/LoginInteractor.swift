//
//  LoginInteractor.swift
//  ModuleArchitectureDemo
//
//  Created by Mladen Despotovic on 29.06.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation
import Networking

protocol LoginInteractor {
    func login(username: String, password: String, completion: @escaping (Result<AuthenticationResponse>) -> Void)
}

final class LoginDefaultInteractor {
    fileprivate let networking: NetworkingType
    
    init(networking: NetworkingType) {
        self.networking = networking
    }
}

// MARK: - LoginInteractor
extension LoginDefaultInteractor: LoginInteractor {
    func login(username: String, password: String, completion: @escaping (Result<AuthenticationResponse>) -> Void) {
        let request = LoginRequest(username: username, password: password)
        networking.execute(request: request, completionHandler: completion)
    }
}

struct LoginRequest: RemoteRequest {
    static var method: HTTPMethod = .get
    static var regexPath: String = "/login"
    static var responseType = AuthenticationResponse.self as Codable.Type
    
    var bodyData: Data?
    
    init(username: String, password: String) {
        let params = ["username": username, "password": password]
        bodyData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
    }
}

