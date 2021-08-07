//
//  NoQuestionsComponent.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/7/21.
//

import UIKit

final class NoQuestionsComponent: UIView, Pressable {

    public var actions: Actions?
    public let configuration = PressableConfiguration(pressScale: .medium)
    
    private var reward: Reward?

    private let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 18
        view.backgroundColor = Color.Primary.OffWhite
        return view
    }()
    
    private let addImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Color.Primary.Black
        imageView.image = #imageLiteral(resourceName: "add")
        return imageView
    }()
    
    private let addQuestionSubtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SFProTextLight(size: 10)
        label.textColor = Color.Primary.GrayText
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "You don't have any questions yet. Click here to add one. Remember to create engaging questions!"
        return label
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        set(isPressed: true, animated: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        set(isPressed: false, animated: true)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        set(isPressed: false, animated: true)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension NoQuestionsComponent {
    func commonInit() {
        configureSubviews()
        configureLayout()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        addGestureRecognizer(tap)
    }
    
    func configureSubviews() {
        addSubview(cardView)
        cardView.addSubviews(addImageView, addQuestionSubtitleLabel)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            addImageView.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.twentyFour),
            addImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            addImageView.heightAnchor.constraint(equalToConstant: 22),
            addImageView.widthAnchor.constraint(equalToConstant: 22),
            
            addQuestionSubtitleLabel.topAnchor.constraint(equalTo: addImageView.bottomAnchor, constant: Spacing.sixteen),
            addQuestionSubtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.twentyFour),
            addQuestionSubtitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            addQuestionSubtitleLabel.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.8)
        ])
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        actions?(.addQuestion)
    }
    
}

//MARK: - Actionable

extension NoQuestionsComponent: Actionable {
    public typealias Actions = (Action) -> Void
    
    public enum Action {
        case addQuestion
    }
}
