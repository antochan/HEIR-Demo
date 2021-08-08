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
    private let authService: AuthService
    private let userService: UserService
    
    lazy var authViewModel: AuthViewModel? = {
        let viewModel = AuthViewModel(authService: authService, userService: userService)
        viewModel.coordinatorDelegate = self
        return viewModel
    }()
    
    init(navigationController: UINavigationController, authService: AuthService, userService: UserService) {
        self.navigationController = navigationController
        self.authService = authService
        self.userService = userService
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

// MARK: - AuthViewModelCoordinatorDelegate

extension AuthCoordinator: AuthViewModelCoordinatorDelegate {
    func routeToAthletePortal(with controller: UINavigationController, user: User) {
        removeAllChildCoordinatorsWith(type: AuthCoordinator.self)
        let athleteHomeCoordinator = AthleteHomeCoordinator(navigationController: controller,
                                                            authService: authService,
                                                            userService: userService,
                                                            quizService: QuizService(),
                                                            user: user)
        athleteHomeCoordinator.start()
    }
    
    func routeToFanPortal(with controller: UINavigationController, user: User) {
        removeAllChildCoordinatorsWith(type: AuthCoordinator.self)
        let fanHomeCoordinator = FanHomeCoordinator(navigationController: controller,
                                                    authService: authService,
                                                    userService: userService,
                                                    quizService: QuizService(),
                                                    user: user)
        fanHomeCoordinator.start()
    }
}
