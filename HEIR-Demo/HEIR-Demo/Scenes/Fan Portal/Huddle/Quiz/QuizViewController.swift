//
//  QuizViewController.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit
import Kingfisher
import Hero

final class QuizViewController: UIViewController {
    // MARK: - View
    let quizView = QuizView()
    
    // MARK: - Properties
    var viewModel: QuizViewModelType? {
        didSet {
            viewModel?.viewDelegate = self
        }
    }
    
    override func loadView() {
        super.loadView()
        view = quizView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        viewModel?.viewDidLoad()
    }
    
    func setupActions() {
        quizView.closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
    }
}

// MARK: - HuddleViewModelViewDelegate

extension QuizViewController: QuizViewModelViewDelegate {
    
    func updateScreen() {
        guard let viewModel = viewModel else { return }
        
        quizView.rewardTitleLabel.text = "Chance to Win\n\(viewModel.quiz.reward.title)"
        print(viewModel.questions)
    }
    
    func loading(_ isLoading: Bool) {
        
    }
    
    func loader(shouldShow: Bool, message: String?) {
        if shouldShow {
            displayLoading(message: message)
        } else {
            dismissAlert()
        }
    }
    
    func presentError(title: String, message: String?) {
        displayAlert(message: message, title: title)
    }
}

// MARK: - Actions

extension QuizViewController {
    
    @objc func closeTapped() {
        viewModel?.close(with: self)
    }
    
}
