//
//  AuthView.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit

final class AuthView: UIView {
    
    private let topHalfView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let bottomHalfView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "Logo")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let textfieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.twelve
        return stackView
    }()
    
    let emailTextField: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.placeholder = "Email"
        textfield.font = UIFont.SFProTextRegular(size: 13)
        return textfield
    }()
    
    let passwordTextField: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.placeholder = "Password"
        textfield.font = UIFont.SFProTextRegular(size: 13)
        textfield.isSecureTextEntry = true
        return textfield
    }()
    
    let loginButton: ButtonComponent = {
        let button = ButtonComponent()
        button.apply(viewModel: ButtonComponent.ViewModel(style: .primary, text: "Log In"))
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

private extension AuthView {
    
    func commonInit() {
        backgroundColor = Color.Primary.BackgroundWhite
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(topHalfView, bottomHalfView)
        topHalfView.addSubview(logoImageView)
        bottomHalfView.addSubview(textfieldStackView)
        textfieldStackView.addArrangedSubviews(emailTextField, passwordTextField, loginButton)
        
        textfieldStackView.setCustomSpacing(Spacing.thirtyTwo, after: passwordTextField)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            topHalfView.topAnchor.constraint(equalTo: topAnchor),
            topHalfView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topHalfView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topHalfView.bottomAnchor.constraint(equalTo: centerYAnchor),
            
            bottomHalfView.topAnchor.constraint(equalTo: centerYAnchor),
            bottomHalfView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomHalfView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomHalfView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            logoImageView.centerXAnchor.constraint(equalTo: topHalfView.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: topHalfView.centerYAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 87),
            logoImageView.widthAnchor.constraint(equalToConstant: 190),
            
            textfieldStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            textfieldStackView.topAnchor.constraint(equalTo: centerYAnchor, constant: Spacing.fortyEight),
            textfieldStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75)
        ])
    }
    
}
