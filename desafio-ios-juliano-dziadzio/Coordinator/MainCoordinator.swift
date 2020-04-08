import Foundation
import UIKit

protocol CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol] {get set}
    var navigationController: UINavigationController {get set}
    
    func start()
}

class MainCoordinator {
    var childCoordinators: [CoordinatorProtocol] = []
    
    var navigationController: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigationController = navigation
    }
    
    func start() {
        let viewController = MainViewController.instantiate()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showCharacterDetails() {
        let viewController = CharactersDetailsViewController.instantiate()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
