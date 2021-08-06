//
//  AuthCoordinator.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit

final class AuthCoordinator: RootCoordinator, Coordinator {
    // MARK: - Properties
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    lazy var authViewModel: AuthViewModel? = {
        let viewModel = AuthViewModel()
        viewModel.coordinatorDelegate = self
        return viewModel
    }()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let authViewController = AuthViewController()
        authViewController.viewModel = authViewModel
        navigationController.setViewControllers([authViewController], animated: false)
        
        addChildCoordinator(self)
    }
    
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T  == false }
    }
    
    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
}

// MARK: - SplashViewModelCoordinatorDelegate

extension AuthCoordinator: AuthViewModelCoordinatorDelegate {

}
