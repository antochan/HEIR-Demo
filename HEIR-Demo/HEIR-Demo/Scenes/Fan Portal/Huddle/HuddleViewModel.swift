//
//  HuddleViewModel.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit
import Firebase

protocol HuddleViewModelType {
    var viewDelegate: HuddleViewModelViewDelegate? { get set }
    var coordinatorDelegate: HuddleViewModelCoordinatorDelegate? { get set }
    
    // Data Source
    var quizService: QuizService { get }
    var athleteId: String { get }
    var user: User { get }
    var quizzes: [Quiz] { get }
    
    /// Events
    func viewDidLoad()
    func fetchQuizzes()
    func launchQuizResultIfPossible(with controller: UINavigationController, quiz: Quiz)
    func launchQuiz(with controller: UINavigationController, quiz: Quiz)
    func close(with controller: UINavigationController)
}

protocol HuddleViewModelCoordinatorDelegate: AnyObject {
    func launchQuiz(with controller: UINavigationController, quiz: Quiz, questions: [Question])
    func launchQuizResult(with controller: UINavigationController, quiz: Quiz)
    func close(with controller: UINavigationController)
}

protocol HuddleViewModelViewDelegate {
    func updateScreen()
    func loading(_ isLoading: Bool)
    func loader(shouldShow: Bool, message: String?)
    func presentError(title: String, message: String?)
}

final class HuddleViewModel {
    // MARK: - Delegates
    var coordinatorDelegate: HuddleViewModelCoordinatorDelegate?
    var viewDelegate: HuddleViewModelViewDelegate?
    
    // MARK: - Properties
    var quizService: QuizService
    var athleteId: String
    var user: User
    var quizzes: [Quiz] = []
    
    init(quizService: QuizService, athleteId: String, user: User) {
        self.quizService = quizService
        self.athleteId = athleteId
        self.user = user
    }
    
}

extension HuddleViewModel: HuddleViewModelType {
    
    func viewDidLoad() {
        viewDelegate?.updateScreen()
        fetchQuizzes()
    }
    
    func fetchQuizzes() {
        viewDelegate?.loading(true)
        quizService.getQuizzes(athleteId: athleteId) { [weak self] result in
            self?.viewDelegate?.loading(false)
            switch result {
            case .success(let quizzes):
                self?.quizzes = quizzes
                self?.viewDelegate?.updateScreen()
            case .failure(let error):
                self?.viewDelegate?.presentError(title: "Something went wrong",
                                                 message: error.errorDescription)
            }
        }
    }
    
    func launchQuizResultIfPossible(with controller: UINavigationController, quiz: Quiz) {
        viewDelegate?.loader(shouldShow: true, message: "Checking...")
        quizService.fetchHasMadeSubmission(athleteId: athleteId,
                                           quizId: quiz.id,
                                           fanId: user.id) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let hasSubmitted):
                if hasSubmitted {
                    strongSelf.viewDelegate?.loader(shouldShow: false, message: nil)
                    strongSelf.coordinatorDelegate?.launchQuizResult(with: controller, quiz: quiz)
                }
                else {
                    strongSelf.viewDelegate?.presentError(title: "You didn't make it",
                                                          message: "Sorry, you didn't participate in the quiz on time!")
                }
            case .failure(let error):
                strongSelf.viewDelegate?.presentError(title: "Something went wrong",
                                                      message: error.errorDescription)
            }
        }
    }
    
    func launchQuiz(with controller: UINavigationController, quiz: Quiz) {
        viewDelegate?.loader(shouldShow: true, message: "Launching...")
        quizService.fetchHasMadeSubmission(athleteId: athleteId,
                                           quizId: quiz.id,
                                           fanId: user.id) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let hasSubmitted):
                if hasSubmitted {
                    strongSelf.viewDelegate?.loader(shouldShow: false, message: nil)
                    strongSelf.coordinatorDelegate?.launchQuizResult(with: controller, quiz: quiz)
                }
                else {
                    strongSelf.quizService.getQuizQuestions(athleteId: strongSelf.athleteId,
                                                            quiz: quiz) { result in
                        strongSelf.viewDelegate?.loader(shouldShow: false, message: nil)
                        switch result {
                        case .success(let questions):
                            strongSelf.coordinatorDelegate?.launchQuiz(with: controller,
                                                                       quiz: quiz,
                                                                       questions: questions)
                        case .failure(let error):
                            strongSelf.viewDelegate?.presentError(title: "Something went wrong",
                                                                  message: error.errorDescription)
                        }
                    }
                }
            case .failure(let error):
                strongSelf.viewDelegate?.presentError(title: "Something went wrong",
                                                      message: error.errorDescription)
            }
        }

    }
    
    func close(with controller: UINavigationController) {
        coordinatorDelegate?.close(with: controller)
    }
}
