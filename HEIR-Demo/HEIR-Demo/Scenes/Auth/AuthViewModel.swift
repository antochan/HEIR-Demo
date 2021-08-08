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
    var userService: UserService { get }
    
    /// Events
    func login(with controller: UINavigationController, email: String?, password: String?)
    func getUser(controller: UINavigationController, uid: String)
}

protocol AuthViewModelCoordinatorDelegate: AnyObject {
    func routeToAthletePortal(with controller: UINavigationController, user: User)
    func routeToFanPortal(with controller: UINavigationController, user: User)
}

protocol AuthViewModelViewDelegate {
    func loading(_ isLoading: Bool)
    func presentError(title: String, message: String?)
}

final class AuthViewModel {
    // MARK: - Delegates
    var coordinatorDelegate: AuthViewModelCoordinatorDelegate?
    var viewDelegate: AuthViewModelViewDelegate?
    
    // MARK: - Properties
    var authService: AuthService
    var userService: UserService
    
    init(authService: AuthService, userService: UserService) {
        self.authService = authService
        self.userService = userService
    }
    
}

extension AuthViewModel: AuthViewModelType {
    
    func login(with controller: UINavigationController, email: String?, password: String?) {
        guard let email = email, let password = password else {
            viewDelegate?.presentError(title: "Invalid Fields",
                                       message: "Please make sure you enter both email and password")
            return
        }
        viewDelegate?.loading(true)
        authService.authenticate(with: email, password: password) { [weak self] result in
            switch result {
            case .success(let authResultData):
                guard let uid = authResultData?.user.uid else {
                    self?.viewDelegate?.presentError(title: "Something went wrong",
                                                     message: "Could not find user details.")
                    self?.viewDelegate?.loading(false)
                    return
                }
                self?.getUser(controller: controller,
                              uid: uid)
            case .failure(let error):
                self?.viewDelegate?.presentError(title: "Oops, Something went wrong",
                                                 message: error.errorDescription)
                self?.viewDelegate?.loading(false)
            }
        }
    }
    
    func getUser(controller: UINavigationController, uid: String) {
        userService.getUser(uid: uid) { [weak self] result in
            switch result {
            case .success(let user):
                switch user.accountType {
                case .athlete:
                    self?.coordinatorDelegate?.routeToAthletePortal(with: controller,
                                                                    user: user)
                case .fan:
                    self?.coordinatorDelegate?.routeToFanPortal(with: controller,
                                                                user: user)
                }
            case .failure(let error):
                self?.viewDelegate?.presentError(title: "Oops, Something went wrong",
                                                 message: error.errorDescription)
            }
            self?.viewDelegate?.loading(false)
        }
    }
    
}
