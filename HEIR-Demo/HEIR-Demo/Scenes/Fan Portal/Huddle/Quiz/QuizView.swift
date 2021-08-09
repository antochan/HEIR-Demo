//
//  QuizView.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit
import Hero

final class QuizView: UIView {
    
    let backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "Glass")
        return imageView
    }()
    
    let rewardTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SFProTextRegular(size: 15)
        label.numberOfLines = 0
        label.textColor = Color.Primary.White
        return label
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = Color.Primary.White
        button.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: Spacing.eight, left: Spacing.eight, bottom: Spacing.eight, right: Spacing.eight)
        return button
    }()
    
    let quizContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let questionsCarousel: QuizQuestionsCarouselComponent = {
        let component = QuizQuestionsCarouselComponent()
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    }()
    
    private let buttonStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.eight
        return stackView
    }()
    
    let timeElapsedButton: ButtonComponent = {
        let button = ButtonComponent()
        button.apply(viewModel: ButtonComponent.ViewModel(style: .secondary, text: "00:00"))
        return button
    }()
    
    let submitButton: ButtonComponent = {
        let button = ButtonComponent()
        button.apply(viewModel: ButtonComponent.ViewModel(style: .primary, text: "Submit"))
        button.isEnabled = false
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

private extension QuizView {
    
    func commonInit() {
        backgroundColor = Color.Primary.White
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(backgroundView, closeButton, rewardTitleLabel, buttonStack, quizContentView)
        buttonStack.addArrangedSubviews(timeElapsedButton, submitButton)
        quizContentView.addSubview(questionsCarousel)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            rewardTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Spacing.sixteen),
            rewardTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Spacing.sixteen),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            closeButton.heightAnchor.constraint(equalToConstant: 25),
            closeButton.widthAnchor.constraint(equalToConstant: 25),
            
            quizContentView.topAnchor.constraint(equalTo: rewardTitleLabel.bottomAnchor, constant: Spacing.sixteen),
            quizContentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.sixteen),
            quizContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.sixteen),
            quizContentView.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -Spacing.sixteen),
            
            questionsCarousel.centerYAnchor.constraint(equalTo: quizContentView.centerYAnchor),
            questionsCarousel.leadingAnchor.constraint(equalTo: quizContentView.leadingAnchor),
            questionsCarousel.trailingAnchor.constraint(equalTo: quizContentView.trailingAnchor),
            questionsCarousel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            buttonStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Spacing.thirtyTwo),
            buttonStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            buttonStack.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
}
