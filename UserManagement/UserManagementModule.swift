//
//  Module.swift
//  UserManagement
//
//  Created by Karim Alweheshy on 2/7/19.
//  Copyright © 2019 Karim Alweheshy. All rights reserved.
//

import UIKit
import Networking

open class UserManagementModule: Module {
    public static var Facade: ModuleFacade.Type = UserManagementModuleFacede.self
    public static var Consumer: ModuleConsumer.Type = UserManagementModuleConsumer.self
}

open class UserManagementModuleFacede: ModuleFacade {
    public static var requestType: [InternalRequest.Type] = [ExplicitLoginRequest.self]
}

open class UserManagementModuleConsumer: ModuleConsumer {
    fileprivate let presentationBlock: ((UIViewController, (() -> Void)?) -> Void)?
    fileprivate let dismissBlock: ((UIViewController, (() -> Void)?) -> Void)?
    
    fileprivate weak var loginViewController: LoginViewController?
    
    required public init(presentationBlock: ((UIViewController, (() -> Void)?) -> Void)?,
                         dismissBlock: ((UIViewController, (() -> Void)?) -> Void)?) {
        self.presentationBlock = presentationBlock
        self.dismissBlock = dismissBlock
    }
    
    public func execute<T: Codable>(networking: NetworkingType, request: InternalRequest, completionHandler: @escaping (Result<T>) -> Void) {
        if let request = request as? ExplicitLoginRequest {
            let loginViewController = LoginBuilder.make(networking: networking, loginData: request.data) { result in
                func reportResult() {
                    guard let result = result as? Result<T> else {
                        completionHandler(.error(ResponseError.other)) //Internal error//
                        return
                    }
                    
                    completionHandler(result)
                }
                if let loginViewController = self.loginViewController {
                    self.dismissBlock?(loginViewController) { reportResult() }
                } else {
                    reportResult()
                }
            }
            self.loginViewController = loginViewController
            presentationBlock?(loginViewController) {}
        } else {
            completionHandler(.error(ResponseError.badRequest400(error: nil)))
        }
    }
}
