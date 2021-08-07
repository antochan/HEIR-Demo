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
    
    let goLiveButton: ButtonComponent = {
        let button = ButtonComponent()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.apply(viewModel: ButtonComponent.ViewModel(style: .primary, text: "Go Live"))
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
        backgroundColor = Color.Primary.BackgroundWhite
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(profileImageView, headerTextStack)
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
            profileImageView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}
