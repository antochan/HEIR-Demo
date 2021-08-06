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
    
    /// Events
}

protocol AuthViewModelCoordinatorDelegate: AnyObject {
}

protocol AuthViewModelViewDelegate {

}

final class AuthViewModel {
    // MARK: - Delegates
    var coordinatorDelegate: AuthViewModelCoordinatorDelegate?
    var viewDelegate: AuthViewModelViewDelegate?
    
    // MARK: - Properties

    
    init() {
    }
    
}

extension AuthViewModel: AuthViewModelType {

}
