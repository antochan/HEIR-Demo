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

    }
    
}

// MARK: - AuthViewModelViewDelegate

extension AuthViewController: AuthViewModelViewDelegate {

}
