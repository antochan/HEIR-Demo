//
//  QuizResultViewController.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit
import Kingfisher
import Hero

final class QuizResultViewController: UIViewController {
    // MARK: - View
    let quizResultView = QuizResultView()
    
    // MARK: - Properties
    var viewModel: QuizResultViewModelType? {
        didSet {
            viewModel?.viewDelegate = self
        }
    }
    
    override func loadView() {
        super.loadView()
        view = quizResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        viewModel?.viewDidLoad()
    }
    
    func setupActions() {
        quizResultView.closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
    }
    
    func createLeaderboardUserLabel(submission: Submission, rank: Int) -> UILabel {
        let label = UILabel()
        label.font = UIFont.SFProTextRegular(size: 15)
        label.textColor = Color.Primary.White
        label.text = "  \(rank). \(submission.fanName) - \(submission.points) points"
        return label
    }
    
    func createQuizSolutionView(quizSelection: QuizSelection, number: Int) -> QuizSelectionResultSolutionComponent {
        let component = QuizSelectionResultSolutionComponent()
        component.apply(viewModel: QuizSelectionResultSolutionComponent.ViewModel(isCorrect: quizSelection.selectedAnswer == quizSelection.question.answer,
                                                                                  questionNumber: number))
        return component
    }
}

// MARK: - HuddleViewModelViewDelegate

extension QuizResultViewController: QuizResultViewModelViewDelegate {
    
    func updateScreen() {
        guard let viewModel = viewModel else { return }
        
        quizResultView.rewardTitleLabel.text = "Chance to Win\n\(viewModel.quiz.reward.title)"
        quizResultView.fanNameLabel.text = "@\(viewModel.user.fullName)"
        
        quizResultView.leadersStack.removeAllArrangedSubviews()
        for (index, submission) in viewModel.submissions.enumerated() {
            quizResultView.leadersStack.addArrangedSubview(createLeaderboardUserLabel(submission: submission, rank: index + 1))
        }
        
        quizResultView.quizSolutionResultStack.removeAllArrangedSubviews()
        for (index, quizSelection) in viewModel.quizSelections.enumerated() {
            quizResultView.quizSolutionResultStack.addArrangedSubview(createQuizSolutionView(quizSelection: quizSelection,
                                                                                             number: index + 1))
        }
        quizResultView.quizSolutionResultStack.addArrangedSubview(UIView())
        
        quizResultView.scoreLabel.text = "\(viewModel.correctScoreCount) out of \(viewModel.quizSelections.count)"
        quizResultView.averageElapsedTimeLabel.text = "You took an average of \(viewModel.averageElapsedTime) seconds per question."
    }
    
    func loading(_ isLoading: Bool) {
        if isLoading {
            quizResultView.scoreLabel.showAnimatedSkeleton()
            quizResultView.averageElapsedTimeLabel.showAnimatedSkeleton()
        } else {
            quizResultView.scoreLabel.hideSkeleton()
            quizResultView.averageElapsedTimeLabel.hideSkeleton()
        }
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

extension QuizResultViewController {
    
    @objc func closeTapped() {
        viewModel?.close()
    }
}
