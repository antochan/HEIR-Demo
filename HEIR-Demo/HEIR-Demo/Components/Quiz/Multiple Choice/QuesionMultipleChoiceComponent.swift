//
//  QuesionMultipleChoiceComponent.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/7/21.
//

import UIKit

final class QuesionMultipleChoiceComponent: UIView, Component {
    struct ViewModel {
        let answer: String
        let isSelected: Bool
    }
    
    public var actions: Actions?
    
    private var answer: String?
    
    private let pillView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.borderColor = Color.Primary.Black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let answerLabel: UILabel = {
        let textfield = UILabel()
        textfield.translatesAutoresizingMaskIntoConstraints = false
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
        button.isUserInteractionEnabled = false
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
    
    func apply(viewModel: ViewModel) {
        answer = viewModel.answer
        selectButton.backgroundColor = viewModel.isSelected ? Color.Primary.Black.withAlphaComponent(0.5) : .clear
        answerLabel.text = viewModel.answer
    }
    
}

private extension QuesionMultipleChoiceComponent {
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubview(pillView)
        pillView.addSubviews(answerLabel, selectButton)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        addGestureRecognizer(tap)
        selectButton.addTarget(self, action: #selector(self.handleTap(_:)), for: .touchUpInside)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            pillView.topAnchor.constraint(equalTo: topAnchor),
            pillView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pillView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pillView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            answerLabel.centerYAnchor.constraint(equalTo: pillView.centerYAnchor),
            answerLabel.leadingAnchor.constraint(equalTo: pillView.leadingAnchor, constant: Spacing.sixteen),
            answerLabel.trailingAnchor.constraint(equalTo: selectButton.leadingAnchor, constant: -Spacing.sixteen),
            
            selectButton.trailingAnchor.constraint(equalTo: pillView.trailingAnchor, constant: -Spacing.sixteen),
            selectButton.centerYAnchor.constraint(equalTo: pillView.centerYAnchor),
            
            selectButton.heightAnchor.constraint(equalToConstant: 20),
            selectButton.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        if let answer = answer {
            actions?(.selected(answer))
        }
    }

}

//MARK: - Actionable

extension QuesionMultipleChoiceComponent: Actionable {
    public typealias Actions = (Action) -> Void
    
    public enum Action {
        case selected(String)
    }
}
