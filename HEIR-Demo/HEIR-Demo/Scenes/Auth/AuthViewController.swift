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

        authView.appearAnimation()
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
    func loading(_ isLoading: Bool) {
        authView.loginButton.loadingIndicator(isLoading)
    }
    
    func presentError(title: String, message: String?) {
        displayAlert(message: message, title: title)
    }
}

// MARK: - Actions

extension AuthViewController {
    
    @objc func logInTapped() {
        if let controller = navigationController {
            viewModel?.login(with: controller,
                             email: authView.emailTextField.text,
                             password: authView.passwordTextField.text)
        }
    }
    
}
