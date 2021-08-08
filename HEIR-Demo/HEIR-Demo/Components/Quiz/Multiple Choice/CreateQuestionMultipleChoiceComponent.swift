//
//  CreateQuestionMultipleChoiceComponent.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/7/21.
//

import UIKit

final class CreateQuestionMultipleChoiceComponent: UIView {
    
    public var actions: Actions?
    
    private let pillView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.borderColor = Color.Primary.Black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let questionTextfield: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.borderStyle = .none
        textfield.font = UIFont.SFProTextRegular(size: 13)
        return textfield
    }()
    
    let selectButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.borderColor = Color.Primary.Black.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .clear
        return button
    }()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: frame.width, height: 40)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func select(isSelected: Bool) {
        selectButton.backgroundColor = isSelected ? Color.Primary.Black.withAlphaComponent(0.5) : .clear
    }
    
}

private extension CreateQuestionMultipleChoiceComponent {
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubview(pillView)
        pillView.addSubviews(questionTextfield, selectButton)
        
        selectButton.addTarget(self, action: #selector(selectAnswer), for: .touchUpInside)
        questionTextfield.addTarget(self, action: #selector(textFieldDidChangeAction(_:)), for: .editingChanged)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            pillView.topAnchor.constraint(equalTo: topAnchor),
            pillView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pillView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pillView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            questionTextfield.centerYAnchor.constraint(equalTo: pillView.centerYAnchor),
            questionTextfield.leadingAnchor.constraint(equalTo: pillView.leadingAnchor, constant: Spacing.sixteen),
            questionTextfield.trailingAnchor.constraint(equalTo: selectButton.leadingAnchor, constant: -Spacing.sixteen),
            
            selectButton.trailingAnchor.constraint(equalTo: pillView.trailingAnchor, constant: -Spacing.sixteen),
            selectButton.centerYAnchor.constraint(equalTo: pillView.centerYAnchor),
            
            selectButton.heightAnchor.constraint(equalToConstant: 20),
            selectButton.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    @objc func selectAnswer() {
        actions?(.selected)
    }
    
    @objc func textFieldDidChangeAction(_ textField: UITextField) {
        actions?(.answerTyped(textField.text))
    }
}

//MARK: - Actionable

extension CreateQuestionMultipleChoiceComponent: Actionable {
    public typealias Actions = (Action) -> Void
    
    public enum Action {
        case selected
        case answerTyped(String?)
    }
}
