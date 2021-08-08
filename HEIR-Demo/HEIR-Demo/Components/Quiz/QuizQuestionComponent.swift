//
//  QuizQuestionComponent.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/7/21.
//

import UIKit

final class QuizQuestionComponent: UIView, Component {

    struct ViewModel {
        let isInCreation: Bool
        let question: Question
        let totalQuestionCount: Int
        let currentQuestionIndex: Int
    }
    
    public var actions: Actions?
    
    private var question: Question?
    
    private let questionCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SFProTextRegular(size: 11)
        return label
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SFProTextLight(size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let multipleChoiceStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.eight
        return stackView
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.SFProTextSemibold(size: 10)
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(Color.Primary.ErrorRed, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func apply(viewModel: ViewModel) {
        question = viewModel.question
        deleteButton.isHidden = !viewModel.isInCreation
        questionCountLabel.textColor = viewModel.isInCreation ? Color.Primary.Black : Color.Primary.White
        questionCountLabel.text = "Question \(viewModel.currentQuestionIndex) of \(viewModel.totalQuestionCount)"
        questionLabel.text = viewModel.question.question
        viewModel.question.options.forEach {
            multipleChoiceStack.addArrangedSubviews(createMultipleChoiceView(option: $0,
                                                                             isSelected: $0 == viewModel.question.answer,
                                                                             isInCreation: viewModel.isInCreation))
        }
    }
    
    @objc func deleteTapped() {
        guard let question = question else { return }
        actions?(.deleteTapped(question))
    }
}

private extension QuizQuestionComponent {
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(questionCountLabel, questionLabel, multipleChoiceStack, deleteButton)
        
        deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            questionCountLabel.topAnchor.constraint(equalTo: topAnchor),
            questionCountLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            questionCountLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor),
            
            deleteButton.centerYAnchor.constraint(equalTo: questionCountLabel.centerYAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.eight),
            
            questionLabel.topAnchor.constraint(equalTo: questionCountLabel.bottomAnchor, constant: Spacing.four),
            questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            questionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            multipleChoiceStack.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: Spacing.sixteen),
            multipleChoiceStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            multipleChoiceStack.widthAnchor.constraint(equalTo: widthAnchor),
            multipleChoiceStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func createMultipleChoiceView(option: String, isSelected: Bool, isInCreation: Bool) -> QuesionMultipleChoiceComponent {
        let component = QuesionMultipleChoiceComponent()
        component.apply(viewModel: QuesionMultipleChoiceComponent.ViewModel(answer: option,
                                                                            isSelected: isSelected,
                                                                            isInteractable: !isInCreation))
        return component
    }
}

//MARK: - Actionable

extension QuizQuestionComponent: Actionable {
    public typealias Actions = (Action) -> Void
    
    public enum Action {
        case deleteTapped(Question)
    }
}
