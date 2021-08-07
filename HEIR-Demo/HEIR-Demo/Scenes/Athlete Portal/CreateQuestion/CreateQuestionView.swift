//
//  CreateQuestionView.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit

final class CreateQuestionView: UIView {
    let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 6.0, left: 6.0, bottom: 6.0, right: 6.0)
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.eight
        return stackView
    }()
    
    private let questionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProTextSemibold(size: 15)
        label.text = "Question"
        return label
    }()
    
    let questionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 8
        textView.layer.borderColor = Color.Primary.GrayText.cgColor
        textView.text = "E.g. What year was I the Rookie of the year?"
        textView.textColor = UIColor.lightGray
        return textView
    }()
    
    private let guidanceTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProTextSemibold(size: 11)
        label.numberOfLines = 0
        label.text = "* please make sure to select the right answer"
        return label
    }()
    
    let multipleChoiceStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.eight
        return stackView
    }()
    
    let answerOne: CreateQuestionMultipleChoiceComponent = {
        let component = CreateQuestionMultipleChoiceComponent()
        component.questionTextfield.placeholder = "E.g. 2021"
        return component
    }()
    
    let answerTwo: CreateQuestionMultipleChoiceComponent = {
        let component = CreateQuestionMultipleChoiceComponent()
        component.questionTextfield.placeholder = "E.g. 2012"
        return component
    }()
    
    let answerThree: CreateQuestionMultipleChoiceComponent = {
        let component = CreateQuestionMultipleChoiceComponent()
        component.questionTextfield.placeholder = "E.g. 2009"
        return component
    }()
    
    let answerFour: CreateQuestionMultipleChoiceComponent = {
        let component = CreateQuestionMultipleChoiceComponent()
        component.questionTextfield.placeholder = "E.g. None of the above"
        return component
    }()
    
    let createQuestionButton: ButtonComponent = {
        let button = ButtonComponent()
        button.apply(viewModel: ButtonComponent.ViewModel(style: .primary, text: "Add Question"))
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension CreateQuestionView {
    
    func commonInit() {
        backgroundColor = Color.Primary.White
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(closeButton, scrollView)
        scrollView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubviews(questionTitleLabel, questionTextView, guidanceTextLabel, multipleChoiceStack, createQuestionButton)
        multipleChoiceStack.addArrangedSubviews(answerOne, answerTwo, answerThree, answerFour)
        
        contentStackView.setCustomSpacing(Spacing.thirtyTwo, after: questionTextView)
        contentStackView.setCustomSpacing(Spacing.thirtyTwo, after: guidanceTextLabel)
        contentStackView.setCustomSpacing(Spacing.fortyEight, after: multipleChoiceStack)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Spacing.twentyFour),
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            closeButton.heightAnchor.constraint(equalToConstant: 25),
            closeButton.widthAnchor.constraint(equalToConstant: 25),
            
            scrollView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: Spacing.eight),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Spacing.fortyEight),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -Spacing.fortyEight),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Spacing.thirtyTwo),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor,  constant: -Spacing.fortyEight * 2),
            
            questionTextView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
}
