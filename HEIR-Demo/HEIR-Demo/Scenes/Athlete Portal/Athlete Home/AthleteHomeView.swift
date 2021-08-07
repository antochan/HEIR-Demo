//
//  AthleteHomeView.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit

final class AthleteHomeView: UIView {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private let headerTextStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.four
        return stackView
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProTextLight(size: 15)
        label.text = "Welcome Back,"
        return label
    }()
    
    let athleteNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProTextSemibold(size: 22)
        return label
    }()
    
    let quizComponent: QuizOverviewComponent = {
        let component = QuizOverviewComponent()
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    }()
    
    private let quizzesTitleStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Spacing.sixteen
        return stackView
    }()
    
    private let quizzesTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProTextSemibold(size: 18)
        label.text = "Your Quizzes"
        return label
    }()
    
    private let createQuizButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Color.Primary.Black
        button.tintColor = Color.Primary.White
        button.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: Spacing.eight, left: Spacing.eight, bottom: Spacing.eight, right: Spacing.eight)
        button.layer.cornerRadius = 12.5
        button.clipsToBounds = true
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

private extension AthleteHomeView {
    
    func commonInit() {
        backgroundColor = Color.Primary.White
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(profileImageView, headerTextStack, quizzesTitleStack, quizComponent)
        quizzesTitleStack.addArrangedSubviews(quizzesTitleLabel, createQuizButton)
        headerTextStack.addArrangedSubviews(welcomeLabel, athleteNameLabel)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            headerTextStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Spacing.sixteen),
            headerTextStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            headerTextStack.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            headerTextStack.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: Spacing.thirtyTwo),
            
            profileImageView.centerYAnchor.constraint(equalTo: headerTextStack.centerYAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            
            quizzesTitleStack.topAnchor.constraint(equalTo: athleteNameLabel.bottomAnchor, constant: Spacing.forty),
            quizzesTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            
            createQuizButton.heightAnchor.constraint(equalToConstant: 25),
            createQuizButton.widthAnchor.constraint(equalToConstant: 25),
            
            quizComponent.centerYAnchor.constraint(equalTo: centerYAnchor),
            quizComponent.centerXAnchor.constraint(equalTo: centerXAnchor),
            quizComponent.widthAnchor.constraint(equalToConstant: 275),
            quizComponent.heightAnchor.constraint(equalToConstant: 125),
        ])
    }
    
}
