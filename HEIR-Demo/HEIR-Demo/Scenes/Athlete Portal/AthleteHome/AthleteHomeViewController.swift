//
//  AthleteHomeViewController.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit
import Kingfisher

final class AthleteHomeViewController: UIViewController {
    // MARK: - View
    let athleteHomeView = AthleteHomeView()
    
    // MARK: - Properties
    var viewModel: AthleteHomeViewModelType? {
        didSet {
            viewModel?.viewDelegate = self
        }
    }
    
    override func loadView() {
        super.loadView()
        view = athleteHomeView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
            
        viewModel?.viewDidLoad()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }
    
    func setupActions() {
        athleteHomeView.createQuizButton.addTarget(self, action: #selector(createQuizTapped), for: .touchUpInside)
        athleteHomeView.quizzesCarouselComponent.delegate = self
    }
}

// MARK: - AthleteHomeViewModelViewDelegate

extension AthleteHomeViewController: AthleteHomeViewModelViewDelegate {
    
    func updateScreen() {
        guard let viewModel = viewModel else { return }
        athleteHomeView.athleteNameLabel.text = viewModel.user.fullName
        athleteHomeView.profileImageView.kf.setImage(with: viewModel.user.userImageURL,
                                                     placeholder: UIImage(named: "placeholder"),
                                                     options: [.transition(.fade(0.3)),
                                                               .keepCurrentImageWhileLoading
                                                     ])
        athleteHomeView.quizzesCarouselComponent.apply(viewModel: QuizzesCarouselComponent.ViewModel(quizzes: viewModel.quizzes))
    }
    
    func loading(_ isLoading: Bool) {
        if isLoading {
            athleteHomeView.quizzesCarouselComponent.collectionView.prepareSkeleton { _ in
                self.athleteHomeView.quizzesCarouselComponent.collectionView.showAnimatedGradientSkeleton()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
                self.athleteHomeView.quizzesCarouselComponent.collectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            })
        }

    }
    
    func presentError(title: String, message: String?) {
        displayAlert(message: message, title: title)
    }
}

// MARK: - Actions

extension AthleteHomeViewController {
    
    @objc func createQuizTapped() {
        guard let controller = navigationController else { return }
        viewModel?.createQuiz(with: controller)
    }
}

// MARK: - QuizzesCarouselComponentDelegate

extension AthleteHomeViewController: QuizzesCarouselComponentDelegate {
    func quizSelected(quiz: Quiz) {
        print(quiz)
    }
}
