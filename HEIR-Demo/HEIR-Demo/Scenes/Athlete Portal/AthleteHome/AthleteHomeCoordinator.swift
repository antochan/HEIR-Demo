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
    private let authService: AuthService
    private let userService: UserService
    private let quizService: QuizService
    private let user: User
    
    lazy var athleteHomeViewModel: AthleteHomeViewModel? = {
        let viewModel = AthleteHomeViewModel(authService: authService,
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
    func createQuiz(with controller: UINavigationController, user: User) {
        removeAllChildCoordinatorsWith(type: AthleteHomeCoordinator.self)
        let createQuizCoordinator = CreateQuizCoordinator(navigationController: controller,
                                                          quizService: quizService,
                                                          user: user)
        createQuizCoordinator.start()
    }
    
    func logOut(with controller: UINavigationController) {
        let authCoordinator = AuthCoordinator(navigationController: navigationController,
                                              authService: authService,
                                              userService: userService)
        authCoordinator.start()
    }
}
