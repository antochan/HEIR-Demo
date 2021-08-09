//
//  FanHomeViewModel.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit
import Firebase

protocol FanHomeViewModelType {
    var viewDelegate: FanHomeViewModelViewDelegate? { get set }
    var coordinatorDelegate: FanHomeViewModelCoordinatorDelegate? { get set }
    
    // Data Source
    var authService: AuthService { get }
    var quizService: QuizService { get }
    var user: User { get }
    
    /// Events
    func viewDidLoad()
    func enterHuddle(with controller: UINavigationController, athleteId: String)
    func logOut(with controller: UINavigationController)
}

protocol FanHomeViewModelCoordinatorDelegate: AnyObject {
    func enterHuddle(with controller: UINavigationController, athleteId: String)
    func logOut(with controller: UINavigationController)
}

protocol FanHomeViewModelViewDelegate {
    func updateScreen()
    func loading(_ isLoading: Bool)
    func presentError(title: String, message: String?)
}

final class FanHomeViewModel {
    // MARK: - Delegates
    var coordinatorDelegate: FanHomeViewModelCoordinatorDelegate?
    var viewDelegate: FanHomeViewModelViewDelegate?
    
    // MARK: - Properties
    var authService: AuthService
    var quizService: QuizService
    var user: User
    var quizzes: [Quiz] = []
    
    init(authService: AuthService, quizService: QuizService, user: User) {
        self.authService = authService
        self.quizService = quizService
        self.user = user
    }
    
}

extension FanHomeViewModel: FanHomeViewModelType {
    
    func viewDidLoad() {
        viewDelegate?.updateScreen()
    }
    
    func enterHuddle(with controller: UINavigationController, athleteId: String) {
        coordinatorDelegate?.enterHuddle(with: controller, athleteId: athleteId)
    }
    
    func logOut(with controller: UINavigationController) {
        do {
            try Auth.auth().signOut()
                coordinatorDelegate?.logOut(with: controller)
            } catch let error {
                viewDelegate?.presentError(title: "Can't Log out",
                                           message: error.localizedDescription)
        }
    }
}
