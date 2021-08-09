//
//  QuizResultCoordinator.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit

final class QuizResultCoordinator: RootCoordinator, Coordinator {
    // MARK: - Properties
    private(set) var childCoordinators: [Coordinator] = []
    
    private let baseController: UINavigationController
    private let controller: UIViewController
    private let quizService: QuizService
    private let user: User
    private let athleteId: String
    private let quiz: Quiz
    
    lazy var quizResultViewModel: QuizResultViewModel? = {
        let viewModel = QuizResultViewModel(quizService: quizService,
                                            user: user,
                                            athleteId: athleteId,
                                            quiz: quiz)
        viewModel.coordinatorDelegate = self
        return viewModel
    }()
    
    init(baseController: UINavigationController, controller: UIViewController, quizService: QuizService, user: User, athleteId: String, quiz: Quiz) {
        self.baseController = baseController
        self.controller = controller
        self.quizService = quizService
        self.user = user
        self.athleteId = athleteId
        self.quiz = quiz
    }
    
    func start() {
        let quizResultViewController = QuizResultViewController()
        quizResultViewController.viewModel = quizResultViewModel
        quizResultViewController.modalPresentationStyle = .fullScreen
        quizResultViewController.modalTransitionStyle = .crossDissolve
        controller.present(quizResultViewController, animated: true)
        
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

// MARK: - QuizResultViewModelCoordinatorDelegate

extension QuizResultCoordinator: QuizResultViewModelCoordinatorDelegate {
    func close() {
        baseController.dismiss(animated: true)
    }
}
