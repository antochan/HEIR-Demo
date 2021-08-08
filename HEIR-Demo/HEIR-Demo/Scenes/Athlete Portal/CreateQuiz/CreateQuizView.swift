//
//  CreateQuizView.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit

final class CreateQuizView: UIView {
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "back"), for: .normal)
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
        stackView.alignment = .center
        stackView.spacing = Spacing.eight
        return stackView
    }()
    
    private let quizDetailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Spacing.eight
        return stackView
    }()
    
    private let headerTextStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Spacing.four
        return stackView
    }()
    
    private let createQuizTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProTextSemibold(size: 22)
        label.text = "Create A Quiz"
        return label
    }()
    
    private let createQuizSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProTextLight(size: 12)
        label.textColor = Color.Primary.GrayText
        label.numberOfLines = 0
        label.text = "Create a quiz to help engagement with your fans. Fill out the entire form and generate some multiple choice questions. Remember the more personal questions the better the engagement."
        return label
    }()
    
    private let quizNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProTextSemibold(size: 15)
        label.text = "Quiz Name"
        return label
    }()
    
    let quizNameTextField: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.placeholder = "E.g. NBA Legends"
        textfield.font = UIFont.SFProTextRegular(size: 13)
        return textfield
    }()
    
    private let launchDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProTextSemibold(size: 15)
        label.text = "Launch Time"
        return label
    }()
    
    let launchDateTextField: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.placeholder = "E.g. Aug, 8th 2021 00:00"
        textfield.font = UIFont.SFProTextRegular(size: 13)
        return textfield
    }()
    
    private let rewardTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProTextSemibold(size: 15)
        label.text = "Pick a Reward"
        return label
    }()
    
    let rewardCarousel: RewardCarouselComponent = {
        let component = RewardCarouselComponent()
        return component
    }()
    
    private let questionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Spacing.sixteen
        return stackView
    }()
    
    private let questionsTitleStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Spacing.eight
        return stackView
    }()
    
    private let questionsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProTextSemibold(size: 15)
        label.text = "Questions"
        return label
    }()
    
    let questionStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Spacing.sixteen
        return stackView
    }()
    
    let addQuestionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Color.Primary.Black
        button.tintColor = Color.Primary.White
        button.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 6.0, left: 6.0, bottom: 6.0, right: 6.0)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    let noQuestionsComponent: NoQuestionsComponent = {
        let component = NoQuestionsComponent()
        return component
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension CreateQuizView {
    
    func commonInit() {
        backgroundColor = Color.Primary.White
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(backButton, scrollView)
        scrollView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubviews(quizDetailsStackView, rewardCarousel, questionsStackView)
        quizDetailsStackView.addArrangedSubviews(headerTextStack, quizNameLabel, quizNameTextField, launchDateLabel, launchDateTextField, rewardTitleLabel)
        
        contentStackView.setCustomSpacing(Spacing.sixteen, after: quizDetailsStackView)
        
        quizDetailsStackView.setCustomSpacing(Spacing.thirtyTwo, after: headerTextStack)
        quizDetailsStackView.setCustomSpacing(Spacing.sixteen, after: quizNameTextField)
        quizDetailsStackView.setCustomSpacing(Spacing.thirtyTwo, after: launchDateTextField)
        
        contentStackView.setCustomSpacing(Spacing.twentyFour, after: rewardCarousel)
        
        questionsStackView.addArrangedSubviews(questionsTitleStack, noQuestionsComponent, questionStack)
        questionsTitleStack.addArrangedSubviews(questionsTitleLabel, addQuestionButton)
        
        headerTextStack.addArrangedSubviews(createQuizTitleLabel, createQuizSubtitleLabel)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Spacing.sixteen),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            backButton.heightAnchor.constraint(equalToConstant: 25),
            backButton.widthAnchor.constraint(equalToConstant: 25),
            
            scrollView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: Spacing.eight),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Spacing.thirtyTwo),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            quizDetailsStackView.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: Spacing.fortyEight),
            quizDetailsStackView.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -Spacing.fortyEight),
            quizDetailsStackView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor, constant: -Spacing.fortyEight * 2),
            
            rewardCarousel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -Spacing.thirtyTwo),
            
            questionsStackView.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: Spacing.fortyEight),
            questionsStackView.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -Spacing.fortyEight),
            questionsStackView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor, constant: -Spacing.fortyEight * 2),
            
            addQuestionButton.heightAnchor.constraint(equalToConstant: 20),
            addQuestionButton.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}
