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
        imageView.isUserInteractionEnabled = true
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
    
    private let quizzesTitleStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Spacing.sixteen
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: Spacing.zero, leading: Spacing.twentyFour, bottom: Spacing.zero, trailing: Spacing.twentyFour)
        return stackView
    }()
    
    private let quizzesTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProTextSemibold(size: 18)
        label.text = "Your Quizzes"
        return label
    }()
    
    let quizzesCarouselComponent: QuizzesCarouselComponent = {
        let component = QuizzesCarouselComponent()
        return component
    }()
    
    let createQuizButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Color.Primary.Black
        button.tintColor = Color.Primary.White
        button.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: Spacing.eight, left: Spacing.eight, bottom: Spacing.eight, right: Spacing.eight)
        button.layer.cornerRadius = 12.5
        button.clipsToBounds = true
        return button
    }()
    
    private let rewardsTitleStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Spacing.sixteen
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: Spacing.zero, leading: Spacing.twentyFour, bottom: Spacing.zero, trailing: Spacing.twentyFour)
        return stackView
    }()
    
    private let rewardsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProTextSemibold(size: 18)
        label.text = "Your Rewards Inventory"
        return label
    }()
    
    let rewardCarousel: RewardCarouselComponent = {
        let component = RewardCarouselComponent()
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

private extension AthleteHomeView {
    
    func commonInit() {
        backgroundColor = Color.Primary.White
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(profileImageView, headerTextStack, scrollView)
        headerTextStack.addArrangedSubviews(welcomeLabel, athleteNameLabel)
        scrollView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubviews(quizzesTitleStack, quizzesCarouselComponent, rewardsTitleStack, rewardCarousel)
        quizzesTitleStack.addArrangedSubviews(quizzesTitleLabel, createQuizButton, UIView())
        rewardsTitleStack.addArrangedSubviews(rewardsTitleLabel)
        
        contentStackView.setCustomSpacing(Spacing.thirtyTwo, after: quizzesCarouselComponent)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            headerTextStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Spacing.sixteen),
            headerTextStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            headerTextStack.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            headerTextStack.trailingAnchor.constraint(equalTo: profileImageView.leadingAnchor, constant: -Spacing.twentyFour),
            
            profileImageView.centerYAnchor.constraint(equalTo: headerTextStack.centerYAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            
            scrollView.topAnchor.constraint(equalTo: headerTextStack.bottomAnchor, constant: Spacing.twentyFour),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Spacing.thirtyTwo),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            createQuizButton.heightAnchor.constraint(equalToConstant: 25),
            createQuizButton.widthAnchor.constraint(equalToConstant: 25),
            
            quizzesCarouselComponent.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
}
