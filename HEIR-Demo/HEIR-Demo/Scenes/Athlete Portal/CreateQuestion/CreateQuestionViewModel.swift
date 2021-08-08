//
//  CreateQuestionViewModel.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit

protocol CreateQuestionViewModelType {
    var viewDelegate: CreateQuestionViewModelViewDelegate? { get set }
    var coordinatorDelegate: CreateQuestionViewModelCoordinatorDelegate? { get set }
    
    // Data Source
    var question: String? { get }
    var answerOne: String? { get }
    var answerTwo: String? { get }
    var answerThree: String? { get }
    var answerFour: String? { get }
    var selectedAnswer: MultipleChoice? { get }
    
    var isFormComplete: Bool { get }
    
    /// Events
    func viewDidLoad()
    func set(question: String?)
    func set(answerOne: String?)
    func set(answerTwo: String?)
    func set(answerThree: String?)
    func set(answerFour: String?)
    func selectAnswer(multipleChoice: MultipleChoice)
    func createQuestion(with controller: UIViewController)
    func close(with controller: UIViewController)
}

protocol CreateQuestionViewModelCoordinatorDelegate: AnyObject {
    func createQuestion(with controller: UIViewController, question: Question)
    func close(with controller: UIViewController)
}

protocol CreateQuestionViewModelViewDelegate {
    func updateScreen()
    func presentError(title: String, message: String?)
}

final class CreateQuestionViewModel {
    // MARK: - Delegates
    var coordinatorDelegate: CreateQuestionViewModelCoordinatorDelegate?
    var viewDelegate: CreateQuestionViewModelViewDelegate?
    
    var question: String?
    var answerOne: String?
    var answerTwo: String?
    var answerThree: String?
    var answerFour: String?
    var selectedAnswer: MultipleChoice?
    
    // MARK: - Properties

    init() {}
    
}

extension CreateQuestionViewModel: CreateQuestionViewModelType {
    
    var isFormComplete: Bool {
        guard !question.isNilOrEmpty,
              !answerOne.isNilOrEmpty,
              !answerTwo.isNilOrEmpty,
              !answerThree.isNilOrEmpty,
              !answerFour.isNilOrEmpty,
              selectedAnswer != nil else {
            return false
        }
        return true
    }
    
    
    func viewDidLoad() {
        viewDelegate?.updateScreen()
    }
    
    func set(question: String?) {
        self.question = question
        viewDelegate?.updateScreen()
    }
    
    func set(answerOne: String?) {
        self.answerOne = answerOne
        viewDelegate?.updateScreen()
    }
    
    func set(answerTwo: String?) {
        self.answerTwo = answerTwo
        viewDelegate?.updateScreen()
    }
    
    func set(answerThree: String?) {
        self.answerThree = answerThree
        viewDelegate?.updateScreen()
    }
    
    func set(answerFour: String?) {
        self.answerFour = answerFour
        viewDelegate?.updateScreen()
    }
    
    func selectAnswer(multipleChoice: MultipleChoice) {
        selectedAnswer = multipleChoice
        viewDelegate?.updateScreen()
    }
    
    func createQuestion(with controller: UIViewController) {
        guard let question = question,
              let answerOne = answerOne,
              let answerTwo = answerTwo,
              let answerThree = answerThree,
              let answerFour = answerFour,
              let selectedAnswer = selectedAnswer else {
            viewDelegate?.presentError(title: "Coudn't create question", message: "Please make sure you have filled out the entire form")
            return
        }
        let answer: String = {
            switch selectedAnswer {
            case .a:
                return answerOne
            case .b:
                return answerTwo
            case .c:
                return answerThree
            case .d:
                return answerFour
            }
        }()
        
        let options = [answerOne, answerTwo, answerThree, answerFour]
        coordinatorDelegate?.createQuestion(with: controller,
                                            question: generateQuestion(question: question,
                                                                       answer: answer,
                                                                       options: options)) 
    }
    
    func close(with controller: UIViewController) {
        coordinatorDelegate?.close(with: controller)
    }
    
}

private func generateQuestion(question: String, answer: String, options: [String]) -> Question {
    return Question(id: UUID().uuidString,
                    question: question,
                    answer: answer,
                    options: options)
}
