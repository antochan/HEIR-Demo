//
//  AuthViewModel.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit

protocol AuthViewModelType {
    var viewDelegate: AuthViewModelViewDelegate? { get set }
    var coordinatorDelegate: AuthViewModelCoordinatorDelegate? { get set }
    
    // Data Source
    var authService: AuthService { get }
    
    /// Events
    func login(with controller: UINavigationController, email: String?, password: String?)
}

protocol AuthViewModelCoordinatorDelegate: AnyObject {
}

protocol AuthViewModelViewDelegate {
    func loading(_ isLoading: Bool)
    func presentError(title: String, message: String)
}

final class AuthViewModel {
    // MARK: - Delegates
    var coordinatorDelegate: AuthViewModelCoordinatorDelegate?
    var viewDelegate: AuthViewModelViewDelegate?
    
    // MARK: - Properties
    var authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
}

extension AuthViewModel: AuthViewModelType {
    
    func login(with controller: UINavigationController, email: String?, password: String?) {
        guard let email = email, let password = password else {
            viewDelegate?.presentError(title: "Invalid Fields", message: "Please make sure you enter both email and password")
            return
        }
        viewDelegate?.loading(true)
        authService.authenticate(with: email, password: password) { [weak self] result in
            switch result {
            case .success(let authResultData):
                print("Successful login: \(authResultData?.user.uid)")
            case .failure(let error):
                self?.viewDelegate?.presentError(title: "Oops, Something went wrong", message: error.localizedDescription)
            }
            self?.viewDelegate?.loading(false)
        }
    }
    
}
