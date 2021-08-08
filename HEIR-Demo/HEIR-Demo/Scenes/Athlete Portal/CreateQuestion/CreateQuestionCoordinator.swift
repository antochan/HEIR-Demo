//
//  CreateQuestionCoordinator.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit

protocol CreateQuestionDelegate: AnyObject {
    func created(question: Question)
}

final class CreateQuestionCoordinator: RootCoordinator, Coordinator {
    // MARK: - Properties
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    weak var delegate: CreateQuestionDelegate?
    
    lazy var createQuestionViewModel: CreateQuestionViewModel? = {
        let viewModel = CreateQuestionViewModel()
        viewModel.coordinatorDelegate = self
        return viewModel
    }()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let createQuestionViewController = CreateQuestionViewController()
        createQuestionViewController.viewModel = createQuestionViewModel
        navigationController.present(createQuestionViewController, animated: true)
        
        addChildCoordinator(self)
    }
    
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T  == false }
    }
    
    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
}

// MARK: - CreateQuestionViewModelCoordinatorDelegate

extension CreateQuestionCoordinator: CreateQuestionViewModelCoordinatorDelegate {
    func createQuestion(with controller: UIViewController, question: Question) {
        controller.dismiss(animated: true)
        delegate?.created(question: question)
    }
    
    func close(with controller: UIViewController) {
        controller.dismiss(animated: true)
    }
}
