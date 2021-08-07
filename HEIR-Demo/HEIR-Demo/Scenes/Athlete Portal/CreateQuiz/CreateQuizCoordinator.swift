//
//  CreateQuizCoordinator.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit

final class CreateQuizCoordinator: RootCoordinator, Coordinator {
    // MARK: - Properties
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private let quizService: QuizService
    private let user: User
    
    lazy var createQuizViewModel: CreateQuizViewModel? = {
        let viewModel = CreateQuizViewModel(quizService: quizService, user: user)
        viewModel.coordinatorDelegate = self
        return viewModel
    }()
    
    init(navigationController: UINavigationController, quizService: QuizService, user: User) {
        self.navigationController = navigationController
        self.quizService = quizService
        self.user = user
    }
    
    func start() {
        let createQuizViewController = CreateQuizViewController()
        createQuizViewController.viewModel = createQuizViewModel
        navigationController.pushViewController(createQuizViewController, animated: true)
        
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

// MARK: - CreateQuizViewModelCoordinatorDelegate

extension CreateQuizCoordinator: CreateQuizViewModelCoordinatorDelegate {
    func dismiss(with controller: UINavigationController) {
        controller.popViewController(animated: true)
    }
}
