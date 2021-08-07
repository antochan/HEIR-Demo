//
//  AthleteHomeCoordinator.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit

final class AthleteHomeCoordinator: RootCoordinator, Coordinator {
    // MARK: - Properties
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private let user: User
    
    lazy var athleteHomeViewModel: AthleteHomeViewModel? = {
        let viewModel = AthleteHomeViewModel(user: user)
        viewModel.coordinatorDelegate = self
        return viewModel
    }()
    
    init(navigationController: UINavigationController, user: User) {
        self.navigationController = navigationController
        self.user = user
    }
    
    func start() {
        let athleteHomeViewController = AthleteHomeViewController()
        athleteHomeViewController.viewModel = athleteHomeViewModel
        navigationController.setViewControllers([athleteHomeViewController], animated: false)
        
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

// MARK: - AthleteHomeViewModelCoordinatorDelegate

extension AthleteHomeCoordinator: AthleteHomeViewModelCoordinatorDelegate {

}
