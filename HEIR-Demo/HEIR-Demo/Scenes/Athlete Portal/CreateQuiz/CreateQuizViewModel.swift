//
//  CreateQuizViewModel.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit

protocol CreateQuizViewModelType {
    var viewDelegate: CreateQuizViewModelViewDelegate? { get set }
    var coordinatorDelegate: CreateQuizViewModelCoordinatorDelegate? { get set }
    
    // Data Source
    var quizService: QuizService { get }
    var user: User { get }
    var selectedReward: Reward? { get }
    var questions: [Question] { get }
    
    /// Events
    func viewDidLoad()
    func rewardSelected(reward: Reward)
    func backTapped(with controller: UINavigationController)
    func addQuestion(with controller: UINavigationController)
}

protocol CreateQuizViewModelCoordinatorDelegate: AnyObject {
    func dismiss(with controller: UINavigationController)
    func addQuestion(with coordinator: CreateQuestionCoordinator)
}

protocol CreateQuizViewModelViewDelegate {
    func updateScreen()
    func loading(_ isLoading: Bool)
    func presentError(title: String, message: String?)
}

final class CreateQuizViewModel {
    // MARK: - Delegates
    var coordinatorDelegate: CreateQuizViewModelCoordinatorDelegate?
    var viewDelegate: CreateQuizViewModelViewDelegate?
    
    // MARK: - Properties
    var quizService: QuizService
    var user: User
    var selectedReward: Reward?
    var questions: [Question] = []
    
    init(quizService: QuizService, user: User) {
        self.quizService = quizService
        self.user = user
    }
    
}

extension CreateQuizViewModel: CreateQuizViewModelType {
    
    func viewDidLoad() {
        viewDelegate?.updateScreen()
    }
    
    func rewardSelected(reward: Reward) {
        selectedReward = reward
    }
    
    func backTapped(with controller: UINavigationController) {
        coordinatorDelegate?.dismiss(with: controller)
    }
    
    func addQuestion(with controller: UINavigationController) {
        let coordinator = CreateQuestionCoordinator(navigationController: controller)
        coordinator.delegate = self
        coordinatorDelegate?.addQuestion(with: coordinator)
    }
    
}

extension CreateQuizViewModel: CreateQuestionDelegate {
    func created(question: Question) {
        questions.append(question)
    }
}
