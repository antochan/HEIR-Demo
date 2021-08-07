//
//  CreateQuestionViewController.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit
import Kingfisher

final class CreateQuestionViewController: UIViewController {
    // MARK: - View
    let createQuestionView = CreateQuestionView()
    
    // MARK: - Properties
    var viewModel: CreateQuestionViewModelType? {
        didSet {
            viewModel?.viewDelegate = self
        }
    }
    
    override func loadView() {
        super.loadView()
        view = createQuestionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        
        viewModel?.viewDidLoad()
    }
    
    func setupActions() {
        createQuestionView.questionTextView.delegate = self
        createQuestionView.closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        
        // Answer One
        createQuestionView.answerOne.actions = { [weak self] action in
            switch action {
            case .selected:
                self?.viewModel?.selectAnswer(multipleChoice: .a)
            case .answerTyped(let answerOne):
                self?.viewModel?.set(answerOne: answerOne)
            }
        }
        
        // Answer Two
        createQuestionView.answerTwo.actions = { [weak self] action in
            switch action {
            case .selected:
                self?.viewModel?.selectAnswer(multipleChoice: .b)
            case .answerTyped(let answerTwo):
                self?.viewModel?.set(answerTwo: answerTwo)
            }
        }
        
        // Answer Three
        createQuestionView.answerThree.actions = { [weak self] action in
            switch action {
            case .selected:
                self?.viewModel?.selectAnswer(multipleChoice: .c)
            case .answerTyped(let answerThree):
                self?.viewModel?.set(answerThree: answerThree)
            }
        }
        
        // Answer Four
        createQuestionView.answerFour.actions = { [weak self] action in
            switch action {
            case .selected:
                self?.viewModel?.selectAnswer(multipleChoice: .d)
            case .answerTyped(let answerFour):
                self?.viewModel?.set(answerFour: answerFour)
            }
        }
    }
}

// MARK: - AthleteHomeViewModelViewDelegate

extension CreateQuestionViewController: CreateQuestionViewModelViewDelegate {
    
    func updateScreen() {
        guard let viewModel = viewModel else { return }
        createQuestionView.answerOne.select(isSelected: viewModel.selectedAnswer == .a)
        createQuestionView.answerTwo.select(isSelected: viewModel.selectedAnswer == .b)
        createQuestionView.answerThree.select(isSelected: viewModel.selectedAnswer == .c)
        createQuestionView.answerFour.select(isSelected: viewModel.selectedAnswer == .d)
        
        createQuestionView.createQuestionButton.isEnabled = viewModel.isFormComplete
    }
    
    func presentError(title: String, message: String?) {
        displayAlert(message: message, title: title)
    }
}

// MARK: - UITextViewDelegate

extension CreateQuestionViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            viewModel?.set(question: nil)
            textView.text = "E.g. What year was I the Rookie of the year?"
            textView.textColor = UIColor.lightGray
        } else {
            viewModel?.set(question: textView.text)
        }
    }
}

// MARK: - Actions

extension CreateQuestionViewController {
    @objc func closeTapped() {
        viewModel?.close(with: self)
    }
}
