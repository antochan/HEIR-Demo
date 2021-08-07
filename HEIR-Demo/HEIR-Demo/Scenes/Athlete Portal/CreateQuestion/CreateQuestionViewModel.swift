//
//  CreateQuestionViewModel.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit

protocol CreateQuestionViewModelType {
    var viewDelegate: CreateQuestionViewModelViewDelegate? { get set }
    var coordinatorDelegate: CreateQuestionViewModelCoordinatorDelegate? { get set }
    
    // Data Source
    
    /// Events
    func viewDidLoad()
    func close(with controller: UIViewController)
}

protocol CreateQuestionViewModelCoordinatorDelegate: AnyObject {
    func close(with controller: UIViewController)
}

protocol CreateQuestionViewModelViewDelegate {
    func updateScreen()
    func loading(_ isLoading: Bool)
    func presentError(title: String, message: String?)
}

final class CreateQuestionViewModel {
    // MARK: - Delegates
    var coordinatorDelegate: CreateQuestionViewModelCoordinatorDelegate?
    var viewDelegate: CreateQuestionViewModelViewDelegate?
    
    // MARK: - Properties

    init() {
    }
    
}

extension CreateQuestionViewModel: CreateQuestionViewModelType {
    
    func viewDidLoad() {
        viewDelegate?.updateScreen()
    }
    
    func close(with controller: UIViewController) {
        coordinatorDelegate?.close(with: controller)
    }
    
}
