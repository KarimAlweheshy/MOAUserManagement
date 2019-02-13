//
//  Module.swift
//  UserManagement
//
//  Created by Karim Alweheshy on 2/7/19.
//  Copyright © 2019 Karim Alweheshy. All rights reserved.
//

import UIKit
import Networking

open class Module: ModuleType {
    public static var capabilities: [InternalRequest.Type] = [ExplicitLoginRequest.self]
    
    fileprivate let presentationBlock: (UIViewController) -> Void
    fileprivate let dismissBlock: (UIViewController) -> Void
    
    public required init(presentationBlock: @escaping (UIViewController) -> Void,
                         dismissBlock: @escaping (UIViewController) -> Void) {
        self.presentationBlock = presentationBlock
        self.dismissBlock = dismissBlock
    }
    
    public func execute<T>(networking: NetworkingType,
                           request: InternalRequest,
                           completionHandler: @escaping (Result<T>) -> Void) {
        guard let completionBlock = completionHandler as? ((Result<AuthenticationResponse>) -> Void) else {
            completionHandler(.error(ResponseError.badRequest400(error: nil)))
            return
        }
        
        if let request = request as? ExplicitLoginRequest {
            var loginViewController: LoginViewController!
            loginViewController = LoginBuilder.make(networking: networking, loginData: request.data) { result in
                self.dismissBlock(loginViewController)
                completionBlock(result)
            }
            presentationBlock(loginViewController)
        } else {
            completionHandler(.error(ResponseError.badRequest400(error: nil)))
        }
    }
}
