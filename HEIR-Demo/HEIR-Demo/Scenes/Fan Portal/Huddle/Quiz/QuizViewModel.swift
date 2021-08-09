//
//  QuizViewModel.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit
import Firebase

protocol QuizViewModelType {
    var viewDelegate: QuizViewModelViewDelegate? { get set }
    var coordinatorDelegate: QuizViewModelCoordinatorDelegate? { get set }
    
    // Data Source
    var quizService: QuizService { get }
    var athleteId: String { get }
    var quiz: Quiz { get }
    var questions: [Question] { get }
    
    /// Events
    func viewDidLoad()
    func close(with controller: UIViewController)
}

protocol QuizViewModelCoordinatorDelegate: AnyObject {
    func close(with controller: UIViewController)
}

protocol QuizViewModelViewDelegate {
    func updateScreen()
    func loading(_ isLoading: Bool)
    func loader(shouldShow: Bool, message: String?)
    func presentError(title: String, message: String?)
}

final class QuizViewModel {
    // MARK: - Delegates
    var coordinatorDelegate: QuizViewModelCoordinatorDelegate?
    var viewDelegate: QuizViewModelViewDelegate?
    
    // MARK: - Properties
    var quizService: QuizService
    var athleteId: String
    var quiz: Quiz
    var questions: [Question]
    
    init(quizService: QuizService, athleteId: String, quiz: Quiz, questions: [Question]) {
        self.quizService = quizService
        self.athleteId = athleteId
        self.quiz = quiz
        self.questions = questions
    }
    
}

extension QuizViewModel: QuizViewModelType {
    
    func viewDidLoad() {
        viewDelegate?.updateScreen()
    }
    
    func close(with controller: UIViewController) {
        coordinatorDelegate?.close(with: controller)
    }
}
