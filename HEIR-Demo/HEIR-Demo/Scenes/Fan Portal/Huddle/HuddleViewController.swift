//
//  HuddleViewController.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit
import Kingfisher
import Hero

final class HuddleViewController: UIViewController {
    // MARK: - View
    let huddleView = HuddleView()
    
    // MARK: - Properties
    var viewModel: HuddleViewModelType? {
        didSet {
            viewModel?.viewDelegate = self
        }
    }
    
    override func loadView() {
        super.loadView()
        view = huddleView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        huddleView.appearAnimation()
        viewModel?.viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }
    
    func setupActions() {
        huddleView.closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        huddleView.quizzesCarouselComponent.delegate = self
    }
}

// MARK: - HuddleViewModelViewDelegate

extension HuddleViewController: HuddleViewModelViewDelegate {
    
    func updateScreen() {
        guard let viewModel = viewModel else { return }
        huddleView.quizzesCarouselComponent.apply(viewModel: QuizzesCarouselComponent.ViewModel(quizzes: viewModel.quizzes,
                                                                                                isAthletePortal: false))
    }
    
    func loading(_ isLoading: Bool) {
        if isLoading {
            huddleView.quizzesCarouselComponent.collectionView.prepareSkeleton { _ in
                self.huddleView.quizzesCarouselComponent.collectionView.showAnimatedGradientSkeleton()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
                self.huddleView.quizzesCarouselComponent.collectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            })
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

extension HuddleViewController {
    
    @objc func closeTapped() {
        guard let controller = navigationController else { return }
        viewModel?.close(with: controller)
    }
    
}

// MARK: - QuizzesCarouselComponentDelegate

extension HuddleViewController: QuizzesCarouselComponentDelegate {
    func quizSelected(quiz: Quiz) {
        // TODO : Do logic around the launch time etc for now always launch quiz
        guard let controller = navigationController else { return }
        viewModel?.launchQuiz(with: controller,
                              quiz: quiz)
        
        // If we are in between the launch and end or the launch has closed
        if Date().timeIntervalSince1970 >= quiz.launchTime {
            
        }
        // We are waiting for launch
        else {
            displayAlert(message: "This quiz is not available to be taken yet.", title: "Slow Down!")
        }
    }
    
    func quizDelete(quiz: Quiz) {
        // There is no delete option on this scene
        // no - op
    }
}

