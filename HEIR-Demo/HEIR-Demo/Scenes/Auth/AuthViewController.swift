//
//  AuthViewController.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit

final class AuthViewController: UIViewController {
    // MARK: - View
    let authView = AuthView()
    
    // MARK: - Properties
    var viewModel: AuthViewModel? {
        didSet {
            viewModel?.viewDelegate = self
        }
    }
    
    override func loadView() {
        super.loadView()
        view = authView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }
    
    func setupActions() {
        authView.loginButton.addTarget(self, action: #selector(logInTapped), for: .touchUpInside)
    }
}

// MARK: - AuthViewModelViewDelegate

extension AuthViewController: AuthViewModelViewDelegate {

}

// MARK: - Actions

extension AuthViewController {
    
    @objc func logInTapped() {
        authView.loginButton.loadingIndicator(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.authView.loginButton.loadingIndicator(false)
        }
    }
    
}
