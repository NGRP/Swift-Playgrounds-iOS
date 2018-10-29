import PlaygroundSupport
import UIKit

@testable import AppStoreFramework

let appsCoordinator = AppsViewCoordinator()

let (parent, child) = playgroundControllers(device: .phone4_7inch, orientation: .portrait, child: appsCoordinator)

PlaygroundPage.current.liveView = parent
