//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import UserManagement
import Networking

let consumer = UserManagementModuleConsumer(presentationBlock: { viewController in
    print("start")
    PlaygroundPage.current.liveView = viewController
}, dismissBlock: { (viewController) in
    print("end")
    PlaygroundPage.current.liveView = nil
})
let request = ExplicitLoginRequest(data: ExplicitLoginRequestBody(email: nil, password: nil))
consumer.execute(request: request) { (result: Result<AuthenticationResponse>) in
    print("end")
    PlaygroundPage.current.liveView = nil
}
