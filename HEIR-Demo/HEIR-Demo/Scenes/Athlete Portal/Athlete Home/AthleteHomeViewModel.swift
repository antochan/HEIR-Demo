//
//  AthleteHomeViewModel.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit

protocol AthleteHomeViewModelType {
    var viewDelegate: AthleteHomeViewModelViewDelegate? { get set }
    var coordinatorDelegate: AthleteHomeViewModelCoordinatorDelegate? { get set }
    
    // Data Source
    var user: User { get }
    
    /// Events
    func viewDidLoad()
}

protocol AthleteHomeViewModelCoordinatorDelegate: AnyObject {
}

protocol AthleteHomeViewModelViewDelegate {
    func updateScreen()
    func loading(_ isLoading: Bool)
    func presentError(title: String, message: String?)
}

final class AthleteHomeViewModel {
    // MARK: - Delegates
    var coordinatorDelegate: AthleteHomeViewModelCoordinatorDelegate?
    var viewDelegate: AthleteHomeViewModelViewDelegate?
    
    // MARK: - Properties
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
}

extension AthleteHomeViewModel: AthleteHomeViewModelType {
    
    func viewDidLoad() {
        viewDelegate?.updateScreen()
    }
    
}
