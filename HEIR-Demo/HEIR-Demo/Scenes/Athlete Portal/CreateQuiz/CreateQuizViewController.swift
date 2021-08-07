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
        setupActions()
        
        viewModel?.viewDidLoad()
    }
    
    func setupActions() {
        createQuizView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        createQuizView.rewardCarousel.delegate = self
    }
}

// MARK: - CreateQuizViewModelViewDelegate

extension CreateQuizViewController: CreateQuizViewModelViewDelegate {
    
    func updateScreen() {
        guard let viewModel = viewModel else { return }
        createQuizView.addQuestionButton.isHidden = viewModel.questions.isEmpty
        createQuizView.noQuestionsComponent.isHidden = !viewModel.questions.isEmpty
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
    
}

// MARK: - RewardCarouselDelegate

extension CreateQuizViewController: RewardCarouselDelegate {
    func rewardSelected(_ reward: Reward) {
        viewModel?.rewardSelected(reward: reward)
    }
}
