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
    
    var quizName: String? { get }
    var launchDate: Double? { get }
    var selectedReward: Reward? { get }
    var questions: [Question] { get }
    
    var isFormComplete: Bool { get }
    
    /// Events
    func viewDidLoad()
    func set(quizName: String?)
    func set(launchDate: Double)
    func rewardSelected(reward: Reward)
    func backTapped(with controller: UINavigationController)
    func remove(question: Question)
    func addQuestion(with controller: UINavigationController)
    func createQuiz(with controller: UINavigationController)
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
    
    var quizName: String?
    var launchDate: Double?
    var selectedReward: Reward?
    var questions: [Question] = []
    
    init(quizService: QuizService, user: User) {
        self.quizService = quizService
        self.user = user
    }
    
}

extension CreateQuizViewModel: CreateQuizViewModelType {
    
    var isFormComplete: Bool {
        guard !quizName.isNilOrEmpty,
              launchDate != nil,
              selectedReward != nil,
              !questions.isEmpty else {
            return false
        }
        return true
    }
    
    
    func viewDidLoad() {
        viewDelegate?.updateScreen()
    }
    
    func set(quizName: String?) {
        self.quizName = quizName
        viewDelegate?.updateScreen()
    }
    
    func set(launchDate: Double) {
        self.launchDate = launchDate
        viewDelegate?.updateScreen()
    }
    
    func rewardSelected(reward: Reward) {
        selectedReward = reward
    }
    
    func backTapped(with controller: UINavigationController) {
        coordinatorDelegate?.dismiss(with: controller)
    }
    
    func remove(question: Question) {
        questions.removeAll { $0 == question }
        viewDelegate?.updateScreen()
    }
    
    func addQuestion(with controller: UINavigationController) {
        let coordinator = CreateQuestionCoordinator(navigationController: controller)
        coordinator.delegate = self
        coordinatorDelegate?.addQuestion(with: coordinator)
    }
    
    func createQuiz(with controller: UINavigationController) {
        guard let quizName = quizName,
              let launchDate = launchDate,
              let reward = selectedReward,
              !questions.isEmpty else {
            viewDelegate?.presentError(title: "Couldn't create quiz", message: "Please make sure you have filled out the entire form")
            return
        }
        viewDelegate?.loading(true)
        quizService.uploadQuiz(athleteId: user.id,
                               quiz: generateQuiz(quizName: quizName,
                                                  reward: reward,
                                                  launchDate: launchDate),
                               questions: questions) { [weak self] result in
            self?.viewDelegate?.loading(false)
            switch result {
            case .success:
                self?.coordinatorDelegate?.dismiss(with: controller)
            case .failure(let error):
                self?.viewDelegate?.presentError(title: "Oops, Something went wrong",
                                                 message: error.errorDescription)
            }
        }
    }
    
}

extension CreateQuizViewModel: CreateQuestionDelegate {
    func created(question: Question) {
        questions.append(question)
        viewDelegate?.updateScreen()
    }
}

private func generateQuiz(quizName: String, reward: Reward, launchDate: Double) -> Quiz {
    return Quiz(id: UUID().uuidString,
                quizName: quizName,
                reward: reward,
                launchTime: launchDate,
                endTime: launchDate + 600 // Adding 600 here means the quiz will be open for 10 minutes.
    )
}
