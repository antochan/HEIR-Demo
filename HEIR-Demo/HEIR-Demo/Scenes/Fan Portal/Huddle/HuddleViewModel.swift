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
    var quizzes: [Quiz] { get }
    
    /// Events
    func viewDidLoad()
    func fetchQuizzes()
    func close(with controller: UINavigationController)
}

protocol HuddleViewModelCoordinatorDelegate: AnyObject {
    func close(with controller: UINavigationController)
}

protocol HuddleViewModelViewDelegate {
    func updateScreen()
    func loading(_ isLoading: Bool)
    func presentError(title: String, message: String?)
}

final class HuddleViewModel {
    // MARK: - Delegates
    var coordinatorDelegate: HuddleViewModelCoordinatorDelegate?
    var viewDelegate: HuddleViewModelViewDelegate?
    
    // MARK: - Properties
    var quizService: QuizService
    var athleteId: String
    var quizzes: [Quiz] = []
    
    init(quizService: QuizService, athleteId: String) {
        self.quizService = quizService
        self.athleteId = athleteId
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
    
    func close(with controller: UINavigationController) {
        coordinatorDelegate?.close(with: controller)
    }
}
