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
    
    /// Events
    func viewDidLoad()
    func createQuiz(with controller: UINavigationController)
}

protocol AthleteHomeViewModelCoordinatorDelegate: AnyObject {
    func createQuiz(with controller: UINavigationController, user: User)
}

protocol AthleteHomeViewModelViewDelegate {
    func updateScreen()
    func loading(_ isLoading: Bool)
    func presentError(title: String, message: String?)
}

final class AthleteHomeViewModel {
    // MARK: - Delegates
    var coordinatorDelegate: AthleteHomeViewModelCoordinatorDelegate?
    var viewDelegate: AthleteHomeViewModelViewDelegate?
    
    // MARK: - Properties
    var quizService: QuizService
    var user: User
    
    init(quizService: QuizService, user: User) {
        self.quizService = quizService
        self.user = user
    }
    
}

extension AthleteHomeViewModel: AthleteHomeViewModelType {
    
    func viewDidLoad() {
        viewDelegate?.updateScreen()
    }
    
    func createQuiz(with controller: UINavigationController) {
        coordinatorDelegate?.createQuiz(with: controller, user: user)
    }
    
}
