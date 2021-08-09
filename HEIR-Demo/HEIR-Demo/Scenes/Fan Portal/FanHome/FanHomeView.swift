//
//  FanHomeView.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit
import Hero

final class FanHomeView: UIView {
    
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
    
    let fanNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProTextSemibold(size: 22)
        return label
    }()
    
    private let fanHomeSubtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SFProTextLight(size: 10)
        label.textColor = Color.Primary.GrayText
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Checkout our HEIR exclusive athletes. Look around and start joining huddles. Within a huddle, you can experience exclusive content only @ HEIR."
        return label
    }()
    
    let lameloBallCard: AthleteBannerComponent = {
        let component = AthleteBannerComponent()
        component.hero.id = "LameloCard"
        component.translatesAutoresizingMaskIntoConstraints = false
        component.apply(viewModel: AthleteBannerComponent.ViewModel(bannerImage: #imageLiteral(resourceName: "lameloBanner"),
                                                                    athleteFirstName: "Lamelo",
                                                                    athleteLastName: "Ball",
                                                                    teamName: "Charlotte Hornets"))
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

private extension FanHomeView {
    
    func commonInit() {
        backgroundColor = Color.Primary.White
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(profileImageView, headerTextStack, fanHomeSubtitleLabel, lameloBallCard)
        headerTextStack.addArrangedSubviews(welcomeLabel, fanNameLabel)
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
            
            fanHomeSubtitleLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Spacing.twentyFour),
            fanHomeSubtitleLabel.leadingAnchor.constraint(equalTo: headerTextStack.leadingAnchor),
            fanHomeSubtitleLabel.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor),
            
            lameloBallCard.centerYAnchor.constraint(equalTo: centerYAnchor),
            lameloBallCard.centerXAnchor.constraint(equalTo: centerXAnchor),
            lameloBallCard.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45),
            lameloBallCard.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.825)
        ])
    }
    
}
