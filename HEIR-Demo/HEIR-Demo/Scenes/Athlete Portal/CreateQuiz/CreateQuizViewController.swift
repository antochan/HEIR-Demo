//
//  CreateQuizViewController.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit

final class CreateQuizViewController: UIViewController {
    // MARK: - View
    let createQuizView = CreateQuizView()
    
    // MARK: - Properties
    var viewModel: CreateQuizViewModelType? {
        didSet {
            viewModel?.viewDelegate = self
        }
    }
    
    override func loadView() {
        super.loadView()
        view = createQuizView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        
    }
    
    func setupActions() {
        createQuizView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
}

// MARK: - CreateQuizViewModelViewDelegate

extension CreateQuizViewController: CreateQuizViewModelViewDelegate {
    
    func updateScreen() {
        
    }
    
    func loading(_ isLoading: Bool) {
        
    }
    
    func presentError(title: String, message: String?) {
        displayAlert(message: message, title: title)
    }
}

// MARK: - Actions

extension CreateQuizViewController {
    
    @objc func backButtonTapped() {
        guard let controller = navigationController else { return }
        viewModel?.backTapped(with: controller)
    }
    
}
