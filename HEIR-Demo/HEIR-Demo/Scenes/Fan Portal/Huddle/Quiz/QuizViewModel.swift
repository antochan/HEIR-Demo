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
    var submission: [QuizSelection] { get }
    var timer: Timer { get }
    var elapsedTime: Int { get }
    
    var currentQuestionIndex: Int { get }
    var currentQuizSelection: QuizSelection? { get }
    
    /// Events
    func viewDidLoad()
    func startTimer()
    func setSelectedAnswer(selectedAnswer: String, question: Question)
    func submit()
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
    var submission: [QuizSelection] = []
    
    internal var timer = Timer()
    internal var elapsedTime = 0
    internal var currentQuestionIndex = 0
    internal var currentQuizSelection: QuizSelection?
    
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
        startTimer()
    }
    
    func startTimer() {
        elapsedTime = 0
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateElapsedTimeButton), userInfo: nil, repeats: true)
    }
    
    func setSelectedAnswer(selectedAnswer: String, question: Question) {
        let quizSelection = QuizSelection(selectedAnswer: selectedAnswer,
                                          timeTaken: elapsedTime,
                                          question: question)
        currentQuizSelection = quizSelection
        viewDelegate?.updateScreen()
    }
    
    func submit() {
        guard let quizSelection = currentQuizSelection else { return }
        submission.append(quizSelection)
        currentQuestionIndex += 1
        currentQuizSelection = nil // reset the current quiz selection
        viewDelegate?.updateScreen()
    }
    
    func close(with controller: UIViewController) {
        coordinatorDelegate?.close(with: controller)
    }
}

// MARK: - Helper

extension QuizViewModel {
    @objc func updateElapsedTimeButton() {
        elapsedTime += 1
        viewDelegate?.updateScreen()
    }
}
