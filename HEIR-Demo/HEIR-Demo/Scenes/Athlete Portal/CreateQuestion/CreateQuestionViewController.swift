//
//  CreateQuestionViewController.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit
import Kingfisher

final class CreateQuestionViewController: UIViewController {
    // MARK: - View
    let createQuestionView = CreateQuestionView()
    
    // MARK: - Properties
    var viewModel: CreateQuestionViewModelType? {
        didSet {
            viewModel?.viewDelegate = self
        }
    }
    
    override func loadView() {
        super.loadView()
        view = createQuestionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        
        viewModel?.viewDidLoad()
    }
    
    func setupActions() {
        createQuestionView.closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
    }
}

// MARK: - AthleteHomeViewModelViewDelegate

extension CreateQuestionViewController: CreateQuestionViewModelViewDelegate {
    
    func updateScreen() {
        
    }
    
    func loading(_ isLoading: Bool) {
        
    }
    
    func presentError(title: String, message: String?) {
        displayAlert(message: message, title: title)
    }
}

// MARK: - Actions

extension CreateQuestionViewController {
    @objc func closeTapped() {
        viewModel?.close(with: self)
    }
}
