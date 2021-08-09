//
//  HuddleViewModel.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit
import Firebase

protocol HuddleViewModelType {
    var viewDelegate: HuddleViewModelViewDelegate? { get set }
    var coordinatorDelegate: HuddleViewModelCoordinatorDelegate? { get set }
    
    // Data Source
    var quizService: QuizService { get }
    var athleteId: String { get }
    
    /// Events
    func viewDidLoad()
    func close(with controller: UINavigationController)
}

protocol HuddleViewModelCoordinatorDelegate: AnyObject {
    func close(with controller: UINavigationController)
}

protocol HuddleViewModelViewDelegate {
    func updateScreen()
    func loading(_ isLoading: Bool)
    func presentError(title: String, message: String?)
}

final class HuddleViewModel {
    // MARK: - Delegates
    var coordinatorDelegate: HuddleViewModelCoordinatorDelegate?
    var viewDelegate: HuddleViewModelViewDelegate?
    
    // MARK: - Properties
    var quizService: QuizService
    var athleteId: String
    
    init(quizService: QuizService, athleteId: String) {
        self.quizService = quizService
        self.athleteId = athleteId
    }
    
}

extension HuddleViewModel: HuddleViewModelType {
    
    func viewDidLoad() {
        viewDelegate?.updateScreen()
    }
    
    func close(with controller: UINavigationController) {
        coordinatorDelegate?.close(with: controller)
    }
}
