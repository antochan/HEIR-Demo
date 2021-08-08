//
//  FanHomeCoordinator.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit

final class FanHomeCoordinator: RootCoordinator, Coordinator {
    // MARK: - Properties
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private let authService: AuthService
    private let userService: UserService
    private let quizService: QuizService
    private let user: User
    
    lazy var fanHomeViewModel: FanHomeViewModel? = {
        let viewModel = FanHomeViewModel(authService: authService,
                                             quizService: quizService,
                                             user: user)
        viewModel.coordinatorDelegate = self
        return viewModel
    }()
    
    init(navigationController: UINavigationController, authService: AuthService, userService: UserService, quizService: QuizService, user: User) {
        self.navigationController = navigationController
        self.authService = authService
        self.userService = userService
        self.quizService = quizService
        self.user = user
    }
    
    func start() {
        let fanHomeViewController = FanHomeViewController()
        fanHomeViewController.viewModel = fanHomeViewModel
        navigationController.setViewControllers([fanHomeViewController], animated: false)
        
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

// MARK: - FanHomeViewModelCoordinatorDelegate

extension FanHomeCoordinator: FanHomeViewModelCoordinatorDelegate {
    
    func logOut(with controller: UINavigationController) {
        let authCoordinator = AuthCoordinator(navigationController: navigationController,
                                              authService: authService,
                                              userService: userService)
        authCoordinator.start()
    }
}
