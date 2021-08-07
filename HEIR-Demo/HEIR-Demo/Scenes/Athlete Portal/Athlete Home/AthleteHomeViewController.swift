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
        navigationController?.setNavigationBarHidden(true, animated: animated)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        
        viewModel?.viewDidLoad()
    }
    
    func setupActions() {
        
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
        let quiz = Quiz(id: "123", quizName: "NBA Legends", reward: .offwhite, launchTime: 1628326315, endTime: 1628326515)
        //1628406600 is 8/8 0:10 and 1628406000 is 8/8 0:00
        athleteHomeView.quizComponent.apply(viewModel: QuizOverviewComponent.ViewModel(quiz: quiz))
    }
    
    func loading(_ isLoading: Bool) {
        
    }
    
    func presentError(title: String, message: String?) {
        displayAlert(message: message, title: title)
    }
}

// MARK: - Actions

extension AthleteHomeViewController {
    
    
}
