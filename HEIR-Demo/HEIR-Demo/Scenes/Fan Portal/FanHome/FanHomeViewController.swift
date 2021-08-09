//
//  FanHomeViewController.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit
import Kingfisher

final class FanHomeViewController: UIViewController {
    // MARK: - View
    let fanHomeView = FanHomeView()
    
    // MARK: - Properties
    var viewModel: FanHomeViewModelType? {
        didSet {
            viewModel?.viewDelegate = self
        }
    }
    
    override func loadView() {
        super.loadView()
        view = fanHomeView
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        fanHomeView.profileImageView.addGestureRecognizer(tap)
        
        fanHomeView.lameloBallCard.actions = { [weak self] action in
            switch action {
            case .athleteSelected(let athleteId):
                guard let controller = self?.navigationController else { return }
                self?.viewModel?.enterHuddle(with: controller,
                                             athleteId: athleteId)
            }
        }
    }
}

// MARK: - FanHomeViewModelViewDelegate

extension FanHomeViewController: FanHomeViewModelViewDelegate {
    
    func updateScreen() {
        guard let viewModel = viewModel else { return }
        fanHomeView.fanNameLabel.text = viewModel.user.fullName
        fanHomeView.profileImageView.kf.setImage(with: viewModel.user.userImageURL,
                                                 placeholder: UIImage(named: "placeholder"),
                                                 options: [.transition(.fade(0.3)),
                                                           .keepCurrentImageWhileLoading
                                                 ])
    }
    
    func loading(_ isLoading: Bool) {
        
    }
    
    func presentError(title: String, message: String?) {
        displayAlert(message: message, title: title)
    }
}

// MARK: - Actions

extension FanHomeViewController {
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Log Out", style: .destructive , handler: { _ in
            guard let controller = self.navigationController else { return }
            self.viewModel?.logOut(with: controller)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
}
