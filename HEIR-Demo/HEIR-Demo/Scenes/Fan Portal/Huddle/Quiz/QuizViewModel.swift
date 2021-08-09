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
    var user: User { get }
    var athleteId: String { get }
    var quiz: Quiz { get }
    var questions: [Question] { get }
    var quizSelections: [QuizSelection] { get }
    var timer: Timer { get }
    var questionElapsedTime: Int { get }
    var elapsedTime: Int { get }
    
    var currentQuestionIndex: Int { get }
    var currentQuizSelection: QuizSelection? { get }
    
    /// Events
    func viewDidLoad()
    func startTimer()
    func setSelectedAnswer(selectedAnswer: String, question: Question)
    func submit(with controller: UIViewController)
    func close(with controller: UIViewController)
}

protocol QuizViewModelCoordinatorDelegate: AnyObject {
    func submit(with controller: UIViewController, quiz: Quiz)
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
    var user: User
    var athleteId: String
    var quiz: Quiz
    var questions: [Question]
    var quizSelections: [QuizSelection] = []
    
    internal var timer = Timer()
    internal var elapsedTime = 0
    internal var questionElapsedTime = 0
    internal var currentQuestionIndex = 0
    internal var currentQuizSelection: QuizSelection?
    
    init(quizService: QuizService, user: User, athleteId: String, quiz: Quiz, questions: [Question]) {
        self.quizService = quizService
        self.user = user
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
        let quizSelection = QuizSelection(id: UUID().uuidString,
                                          selectedAnswer: selectedAnswer,
                                          timeTaken: questionElapsedTime,
                                          question: question)
        currentQuizSelection = quizSelection
        viewDelegate?.updateScreen()
    }
    
    func submit(with controller: UIViewController) {
        if currentQuestionIndex == questions.count - 1 && quizSelections.count == questions.count - 1 {
            guard let quizSelection = currentQuizSelection else { return }
            quizSelections.append(quizSelection)
            
            viewDelegate?.loader(shouldShow: true, message: "Submitting...")
            quizService.makeSubmission(athleteId: athleteId,
                                       quizId: quiz.id,
                                       fanId: user.id,
                                       submission: generateSubmission(from: quizSelections,
                                                                      user: user),
                                       quizSelections: quizSelections) { [weak self] result in
                guard let strongSelf = self else { return }
                strongSelf.viewDelegate?.loader(shouldShow: false, message: nil)
                switch result {
                case .success:
                    strongSelf.coordinatorDelegate?.submit(with: controller,
                                                           quiz: strongSelf.quiz)
                case .failure(let error):
                    strongSelf.viewDelegate?.presentError(title: "Couldn't complete quiz",
                                                          message: error.errorDescription)
                }
            }
        } else {
            /// We are still answering questions in the quiz, update our state and continue on with the quiz
            guard let quizSelection = currentQuizSelection else { return }
            quizSelections.append(quizSelection)
            currentQuestionIndex += 1
            currentQuizSelection = nil /// reset the current quiz selection
            questionElapsedTime = 0
            viewDelegate?.updateScreen()
        }
    }
    
    func close(with controller: UIViewController) {
        coordinatorDelegate?.close(with: controller)
    }
}

// MARK: - Helper

extension QuizViewModel {
    @objc func updateElapsedTimeButton() {
        elapsedTime += 1
        questionElapsedTime += 1
        viewDelegate?.updateScreen()
    }
}

private func generateSubmission(from quizSelections: [QuizSelection], user: User) -> Submission {
    var totalPoints = 0
    for selection in quizSelections {
        // Fan got the right answer, use time to determine point
        if selection.selectedAnswer == selection.question.answer {
            // Fan got answer immediately
            if selection.timeTaken == 0 {
                totalPoints += 10
            }
            // Fan took more than 10 seconds, only one point
            else if selection.timeTaken >= 10 {
                totalPoints += 1
            }
            // Fan took between 1 to 9 seconds
            else {
                totalPoints += (1 * (10 - selection.timeTaken))
            }
        }
    }
    return Submission(id: user.id,
                      points: Double(totalPoints),
                      submittedAt: Date().timeIntervalSince1970,
                      fanName: user.fullName,
                      fanImageURL: user.userImageURL)
}
