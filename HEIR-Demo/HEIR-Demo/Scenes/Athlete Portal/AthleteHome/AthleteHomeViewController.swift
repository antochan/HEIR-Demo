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
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        athleteHomeView.profileImageView.addGestureRecognizer(tap)
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
        athleteHomeView.quizzesCarouselComponent.apply(viewModel: QuizzesCarouselComponent.ViewModel(quizzes: viewModel.quizzes,
                                                                                                     isAthletePortal: true))
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

extension AthleteHomeViewController {
    
    @objc func createQuizTapped() {
        guard let controller = navigationController else { return }
        viewModel?.createQuiz(with: controller)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Log Out", style: .destructive , handler: { _ in
            print("logged out")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
}

// MARK: - QuizzesCarouselComponentDelegate

extension AthleteHomeViewController: QuizzesCarouselComponentDelegate {
    func quizSelected(quiz: Quiz) {
        print(quiz)
    }
    
    func quizDelete(quiz: Quiz) {
        let alert = UIAlertController(title: "Delete Quiz",
                                      message: "Are you sure you want to delete quiz? Fans will likely see this!",
                                      preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler: { _ in
            self.viewModel?.deleteQuiz(quiz: quiz)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
}
