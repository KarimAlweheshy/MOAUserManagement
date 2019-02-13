//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import UserManagement
import Networking

let consumer = UserManagementModuleConsumer(presentationBlock: { (viewController, _) in
    print("start")
    PlaygroundPage.current.liveView = viewController
}, dismissBlock: { (viewController, _) in
    print("end")
    PlaygroundPage.current.liveView = nil
})
let request = ExplicitLoginRequest(data: ExplicitLoginRequestBody(email: nil, password: nil))

final class Networking: NetworkingType {
    func register(module: Module.Type) {}
    
    func execute<T: Codable>(request: InternalRequest,
                             presentationBlock: ((UIViewController, (() -> Void)?) -> Void)?,
                             dismissBlock: ((UIViewController, (() -> Void)?) -> Void)?,
                             completionHandler: @escaping (Result<T>) -> Void) {
        print("ask for auth token")
    }
    
    func execute<T: Codable>(request: InternalRequest,
                             completionHandler: @escaping (Result<T>) -> Void) {
        print("ask for auth token")
    }
    
    func execute<T: Codable>(request: RemoteRequest,
                             completionHandler: @escaping (Result<T>) -> Void) {}
}

consumer.execute(networking: Networking(), request: request) { (result: Result<AuthenticationResponse>) in
    print("end")
    PlaygroundPage.current.liveView = nil
}
