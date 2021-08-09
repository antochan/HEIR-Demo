//
//  QuizResultViewModel.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit
import Firebase

protocol QuizResultViewModelType {
    var viewDelegate: QuizResultViewModelViewDelegate? { get set }
    var coordinatorDelegate: QuizResultViewModelCoordinatorDelegate? { get set }
    
    // Data Source
    var quizService: QuizService { get }
    var user: User { get }
    var athleteId: String { get }
    var quiz: Quiz { get }
    var submissions: [Submission] { get }
    var quizSelections: [QuizSelection] { get }
    
    var correctScoreCount: Int { get }
    var averageElapsedTime: Double { get }
    
    /// Events
    func viewDidLoad()
    func fetchSubmissions()
    func fetchQuizSelections()
    func close()
}

protocol QuizResultViewModelCoordinatorDelegate: AnyObject {
    func close()
}

protocol QuizResultViewModelViewDelegate {
    func updateScreen()
    func loading(_ isLoading: Bool)
    func loader(shouldShow: Bool, message: String?)
    func presentError(title: String, message: String?)
}

final class QuizResultViewModel {
    // MARK: - Delegates
    var coordinatorDelegate: QuizResultViewModelCoordinatorDelegate?
    var viewDelegate: QuizResultViewModelViewDelegate?
    
    // MARK: - Properties
    var quizService: QuizService
    var user: User
    var athleteId: String
    var quiz: Quiz
    var submissions: [Submission] = []
    var quizSelections: [QuizSelection] = []
    
    init(quizService: QuizService, user: User, athleteId: String, quiz: Quiz) {
        self.quizService = quizService
        self.user = user
        self.athleteId = athleteId
        self.quiz = quiz
    }
    
}

extension QuizResultViewModel: QuizResultViewModelType {
    
    func viewDidLoad() {
        viewDelegate?.updateScreen()
        fetchSubmissions()
        fetchQuizSelections()
    }
    
    func fetchSubmissions() {
        viewDelegate?.loading(true)
        quizService.fetchSubmissions(athleteId: athleteId,
                                     quizId: quiz.id) { [weak self] result in
            self?.viewDelegate?.loading(false)
            switch result {
            case .success(let submissions):
                self?.submissions = submissions
                self?.viewDelegate?.updateScreen()
            case .failure(let error):
                self?.viewDelegate?.presentError(title: "Something went wrong",
                                                 message: error.errorDescription)
            }
        }
    }
    
    func fetchQuizSelections() {
        viewDelegate?.loading(true)
        quizService.fetchQuizSelections(athleteId: athleteId,
                                        quizId: quiz.id,
                                        fanId: user.id) { [weak self] result in
            self?.viewDelegate?.loading(false)
            switch result {
            case .success(let quizSelections):
                self?.quizSelections = quizSelections
                self?.viewDelegate?.updateScreen()
            case .failure(let error):
                self?.viewDelegate?.presentError(title: "Something went wrong",
                                                 message: error.errorDescription)
            }
        }
    }
    
    func close() {
        coordinatorDelegate?.close()
    }
}

// MARK: - Raw Data

extension QuizResultViewModel {
    var correctScoreCount: Int {
        var score = 0
        quizSelections.forEach {
            if $0.selectedAnswer == $0.question.answer {
                score += 1
            }
        }
        return score
    }
    
    var averageElapsedTime: Double {
        let toatlElapsedTime = quizSelections.map { return $0.timeTaken }.reduce(0, +)
        return Double(Double(toatlElapsedTime) / Double(quizSelections.count))
    }
}
