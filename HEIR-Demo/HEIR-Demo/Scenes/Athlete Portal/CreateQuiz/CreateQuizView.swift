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
        button.imageEdgeInsets = UIEdgeInsets(top: Spacing.four, left: Spacing.four, bottom: Spacing.four, right: Spacing.four)
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

private extension CreateQuizView {
    
    func commonInit() {
        backgroundColor = Color.Primary.White
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(backButton)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Spacing.sixteen),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            backButton.heightAnchor.constraint(equalToConstant: 25),
            backButton.widthAnchor.constraint(equalToConstant: 25),
        ])
    }
    
}
