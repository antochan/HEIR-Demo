//
//  HuddleView.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit
import Hero

final class HuddleView: UIView {
    
    let lameloBallCard: AthleteBannerComponent = {
        let component = AthleteBannerComponent()
        component.translatesAutoresizingMaskIntoConstraints = false
        component.configuration = PressableConfiguration(pressScale: .none)
        component.hero.id = "LameloCard"
        component.apply(viewModel: AthleteBannerComponent.ViewModel(cardColor: Color.Primary.White,
                                                                    bannerImage: #imageLiteral(resourceName: "lameloBanner"),
                                                                    athleteFirstName: "Lamelo",
                                                                    athleteLastName: "Ball",
                                                                    teamName: "Charlotte Hornets"))
        return component
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Color.Primary.Black
        button.tintColor = Color.Primary.White
        button.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: Spacing.eight, left: Spacing.eight, bottom: Spacing.eight, right: Spacing.eight)
        button.layer.cornerRadius = 12.5
        button.clipsToBounds = true
        button.alpha = 0
        return button
    }()
    
    private let overviewView: RoundedShadowView = {
        let view = RoundedShadowView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12.0
        view.backgroundColor = Color.Primary.White
        view.alpha = 0
        return view
    }()
    
    private let quizzesTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SFProTextSemibold(size: 18)
        label.text = "Quizzes"
        label.alpha = 0
        return label
    }()
    
    let quizzesCarouselComponent: QuizzesCarouselComponent = {
        let component = QuizzesCarouselComponent()
        component.translatesAutoresizingMaskIntoConstraints = false
        component.alpha = 0
        return component
    }()
    
    private let moodStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = Spacing.four
        stackView.axis = .vertical
        return stackView
    }()
    
    private let moodLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProTextSemibold(size: 10)
        label.text = "Mood"
        return label
    }()
    
    private let moodIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "happy")
        return imageView
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Color.Primary.LightGray
        return view
    }()
    
    private let huddleBioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SFProTextLight(size: 10)
        label.textColor = Color.Primary.GrayText
        label.numberOfLines = 0
        label.text = "Hey whatsup ya'll. Welcome to my huddle, I'm gonna be dropping my newest merch here exclusively so be on the lookout."
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func appearAnimation() {
        closeButton.fadeIn(duration: 0.4, delay: 0.1)
        overviewView.fadeIn(duration: 0.4, delay: 0.1)
        quizzesTitleLabel.fadeIn(duration: 0.4, delay: 0.1)
        quizzesCarouselComponent.fadeIn(duration: 0.4, delay: 0.1)
    }
    
}

private extension HuddleView {
    
    func commonInit() {
        backgroundColor = Color.Primary.White
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(lameloBallCard, closeButton, overviewView, quizzesTitleLabel, quizzesCarouselComponent)
        overviewView.addSubviews(moodStack, dividerView, huddleBioLabel)
        
        moodStack.addArrangedSubviews(moodLabel, moodIcon)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            lameloBallCard.topAnchor.constraint(equalTo: topAnchor),
            lameloBallCard.centerXAnchor.constraint(equalTo: centerXAnchor),
            lameloBallCard.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.55),
            lameloBallCard.widthAnchor.constraint(equalTo: widthAnchor),
            
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Spacing.sixteen),
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            closeButton.heightAnchor.constraint(equalToConstant: 25),
            closeButton.widthAnchor.constraint(equalToConstant: 25),
            
            overviewView.centerXAnchor.constraint(equalTo: centerXAnchor),
            overviewView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            overviewView.centerYAnchor.constraint(equalTo: lameloBallCard.bottomAnchor, constant: Spacing.twelve),
            overviewView.heightAnchor.constraint(equalToConstant: 60),
            
            quizzesTitleLabel.topAnchor.constraint(equalTo: overviewView.bottomAnchor, constant: Spacing.twentyFour),
            quizzesTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            
            quizzesCarouselComponent.topAnchor.constraint(equalTo: quizzesTitleLabel.bottomAnchor, constant: Spacing.eight),
            quizzesCarouselComponent.leadingAnchor.constraint(equalTo: leadingAnchor),
            quizzesCarouselComponent.trailingAnchor.constraint(equalTo: trailingAnchor),
            quizzesCarouselComponent.heightAnchor.constraint(equalToConstant: 125),
            
            moodStack.centerYAnchor.constraint(equalTo: overviewView.centerYAnchor),
            moodStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.thirtyTwo),
            
            moodIcon.heightAnchor.constraint(equalToConstant: 22),
            moodIcon.widthAnchor.constraint(equalToConstant: 22),
            
            dividerView.leadingAnchor.constraint(equalTo: moodStack.trailingAnchor, constant: Spacing.twentyFour),
            dividerView.heightAnchor.constraint(equalTo: overviewView.heightAnchor, multiplier: 0.85),
            dividerView.centerYAnchor.constraint(equalTo: overviewView.centerYAnchor),
            dividerView.widthAnchor.constraint(equalToConstant: 1),

            huddleBioLabel.centerYAnchor.constraint(equalTo: overviewView.centerYAnchor),
            huddleBioLabel.leadingAnchor.constraint(equalTo: dividerView.trailingAnchor, constant: Spacing.twentyFour),
            huddleBioLabel.trailingAnchor.constraint(equalTo: overviewView.trailingAnchor, constant: -Spacing.twentyFour)
        ])
    }
    
}
