//
//  CreateQuizViewController.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit

final class CreateQuizViewController: UIViewController {
    // MARK: - View
    let createQuizView = CreateQuizView()
    
    // MARK: - Properties
    var viewModel: CreateQuizViewModelType? {
        didSet {
            viewModel?.viewDelegate = self
        }
    }
    
    override func loadView() {
        super.loadView()
        view = createQuizView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTapped(on: createQuizView)
        setupActions()
        
        viewModel?.viewDidLoad()
    }
    
    func setupActions() {
        createQuizView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        createQuizView.rewardCarousel.delegate = self
        
        createQuizView.addQuestionButton.addTarget(self, action: #selector(addQuestionTapped), for: .touchUpInside)
        createQuizView.noQuestionsComponent.actions = { [weak self] _ in
            self?.addQuestionTapped()
        }
    }
    
    func createMultipleChoiceView(question: Question, totalQuestionCount: Int, questionIndex: Int) -> QuizQuestionComponent {
        let component = QuizQuestionComponent()
        component.apply(viewModel: QuizQuestionComponent.ViewModel(isInCreation: true,
                                                                   question: question,
                                                                   totalQuestionCount: totalQuestionCount,
                                                                   currentQuestionIndex: questionIndex))
        return component
    }
}

// MARK: - CreateQuizViewModelViewDelegate

extension CreateQuizViewController: CreateQuizViewModelViewDelegate {
    
    func updateScreen() {
        guard let viewModel = viewModel else { return }
        createQuizView.addQuestionButton.isHidden = viewModel.questions.isEmpty
        createQuizView.noQuestionsComponent.isHidden = !viewModel.questions.isEmpty
        
        createQuizView.questionStack.removeAllArrangedSubviews()
        for (index, question) in viewModel.questions.enumerated() {
            createQuizView.questionStack.addArrangedSubviews(createMultipleChoiceView(question: question,
                                                                                      totalQuestionCount: viewModel.questions.count,
                                                                                      questionIndex: index + 1))
        }
    }
    
    func loading(_ isLoading: Bool) {
        
    }
    
    func presentError(title: String, message: String?) {
        displayAlert(message: message, title: title)
    }
}

// MARK: - Actions

extension CreateQuizViewController {
    
    @objc func backButtonTapped() {
        guard let controller = navigationController else { return }
        viewModel?.backTapped(with: controller)
    }
    
    @objc func addQuestionTapped() {
        guard let controller = navigationController else { return }
        viewModel?.addQuestion(with: controller)
    }
}

// MARK: - RewardCarouselDelegate

extension CreateQuizViewController: RewardCarouselDelegate {
    func rewardSelected(_ reward: Reward) {
        viewModel?.rewardSelected(reward: reward)
    }
}
