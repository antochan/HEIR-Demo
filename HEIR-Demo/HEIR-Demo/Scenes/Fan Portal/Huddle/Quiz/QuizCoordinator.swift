//
//  QuizCoordinator.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit

final class QuizCoordinator: RootCoordinator, Coordinator {
    // MARK: - Properties
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private let quizService: QuizService
    private let athleteId: String
    private let quiz: Quiz
    private let questions: [Question]
    
    lazy var quizViewModel: QuizViewModel? = {
        let viewModel = QuizViewModel(quizService: quizService,
                                      athleteId: athleteId,
                                      quiz: quiz,
                                      questions: questions)
        viewModel.coordinatorDelegate = self
        return viewModel
    }()
    
    init(controller: UINavigationController, quizService: QuizService, athleteId: String, quiz: Quiz, questions: [Question]) {
        self.navigationController = controller
        self.quizService = quizService
        self.athleteId = athleteId
        self.quiz = quiz
        self.questions = questions
    }
    
    func start() {
        let quizViewController = QuizViewController()
        quizViewController.viewModel = quizViewModel
        quizViewController.modalPresentationStyle = .fullScreen
        quizViewController.modalTransitionStyle = .crossDissolve
        navigationController.present(quizViewController, animated: true)
        
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

// MARK: - QuizViewModelCoordinatorDelegate

extension QuizCoordinator: QuizViewModelCoordinatorDelegate {
    
    func close(with controller: UIViewController) {
        controller.modalTransitionStyle = .crossDissolve
        controller.dismiss(animated: true)
    }
}
