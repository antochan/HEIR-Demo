//
//  AthleteHomeViewModel.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit

protocol AthleteHomeViewModelType {
    var viewDelegate: AthleteHomeViewModelViewDelegate? { get set }
    var coordinatorDelegate: AthleteHomeViewModelCoordinatorDelegate? { get set }
    
    // Data Source
    var quizService: QuizService { get }
    var user: User { get }
    var quizzes: [Quiz] { get }
    
    /// Events
    func viewDidLoad()
    func fetchQuizzes()
    func createQuiz(with controller: UINavigationController)
    func deleteQuiz(quiz: Quiz)
}

protocol AthleteHomeViewModelCoordinatorDelegate: AnyObject {
    func createQuiz(with controller: UINavigationController, user: User)
}

protocol AthleteHomeViewModelViewDelegate {
    func updateScreen()
    func loading(_ isLoading: Bool)
    func loader(shouldShow: Bool, message: String?)
    func presentError(title: String, message: String?)
}

final class AthleteHomeViewModel {
    // MARK: - Delegates
    var coordinatorDelegate: AthleteHomeViewModelCoordinatorDelegate?
    var viewDelegate: AthleteHomeViewModelViewDelegate?
    
    // MARK: - Properties
    var quizService: QuizService
    var user: User
    var quizzes: [Quiz] = []
    
    init(quizService: QuizService, user: User) {
        self.quizService = quizService
        self.user = user
    }
    
}

extension AthleteHomeViewModel: AthleteHomeViewModelType {
    
    func viewDidLoad() {
        viewDelegate?.updateScreen()
        fetchQuizzes()
    }
    
    func fetchQuizzes() {
        viewDelegate?.loading(true)
        quizService.getQuizzes(athleteId: user.id) { [weak self] result in
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
    
    func createQuiz(with controller: UINavigationController) {
        coordinatorDelegate?.createQuiz(with: controller, user: user)
    }
    
    func deleteQuiz(quiz: Quiz) {
        viewDelegate?.loader(shouldShow: true, message: "Deleting...")
        quizService.deleteQuiz(athleteId: user.id,
                               quizId: quiz.id) { [weak self] result in
            self?.viewDelegate?.loader(shouldShow: false, message: nil)
            switch result {
            case .success:
                self?.fetchQuizzes()
            case .failure(let error):
                self?.viewDelegate?.presentError(title: "Couldn't delete quiz",
                                                 message: error.errorDescription)
            }
        }
    }
    
}
