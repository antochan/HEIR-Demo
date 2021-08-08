//
//  AuthView.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit

final class AuthView: UIView {
    
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
        imageView.alpha = 0
        return imageView
    }()
    
    private let textfieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.twelve
        stackView.alpha = 0
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
    
    func appearAnimation() {
        logoImageView.transform = .identity
        logoImageView.fadeIn(duration: 0.6, delay: 0)
        UIView.animate(withDuration: 0.6,
                       delay: 0.8,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseIn) {
            self.logoImageView.transform = CGAffineTransform(translationX: 0, y: -125)
        }
        textfieldStackView.fadeIn(duration: 0.4, delay: 1)
    }
    
}

private extension AuthView {
    
    func commonInit() {
        backgroundColor = Color.Primary.White
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(logoImageView, bottomHalfView)
        bottomHalfView.addSubview(textfieldStackView)
        textfieldStackView.addArrangedSubviews(emailTextField, passwordTextField, loginButton)
        
        textfieldStackView.setCustomSpacing(Spacing.thirtyTwo, after: passwordTextField)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            bottomHalfView.topAnchor.constraint(equalTo: centerYAnchor),
            bottomHalfView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomHalfView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomHalfView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 87),
            logoImageView.widthAnchor.constraint(equalToConstant: 190),
            
            textfieldStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            textfieldStackView.topAnchor.constraint(equalTo: centerYAnchor, constant: Spacing.fortyEight),
            textfieldStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75)
        ])
    }
    
}
