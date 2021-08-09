//
//  QuizSelectionResultSolutionComponent.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/9/21.
//

import UIKit

final class QuizSelectionResultSolutionComponent: UIView, Component {
    struct ViewModel {
        let isCorrect: Bool
        let questionNumber: Int
    }
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.four
        stackView.alignment = .center
        return stackView
    }()
    
    private let solutionButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = Color.Primary.White.cgColor
        button.backgroundColor = Color.Primary.White.withAlphaComponent(0.5)
        button.tintColor = Color.Primary.White
        button.layer.cornerRadius = 10
        button.imageEdgeInsets = UIEdgeInsets(top: Spacing.four, left: Spacing.four, bottom: Spacing.four, right: Spacing.four)
        return button
    }()
    
    private let questionNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.Primary.White
        label.font = UIFont.SFProTextMedium(size: 13)
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func apply(viewModel: ViewModel) {
        solutionButton.setImage(viewModel.isCorrect ? #imageLiteral(resourceName: "checked") : #imageLiteral(resourceName: "close"), for: .normal)
        questionNumberLabel.text = "Q\(viewModel.questionNumber)"
    }
}

private extension QuizSelectionResultSolutionComponent {
    
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubview(stackView)
        
        stackView.addArrangedSubviews(solutionButton, questionNumberLabel)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            solutionButton.heightAnchor.constraint(equalToConstant: 20),
            solutionButton.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}
