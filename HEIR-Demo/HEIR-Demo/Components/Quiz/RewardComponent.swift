//
//  RewardComponent.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/7/21.
//

import UIKit

final class RewardComponent: UIView, Component, Pressable, Reusable {
    struct ViewModel {
        let reward: Reward
        let isSelected: Bool
    }
    
    public var actions: Actions?
    public let configuration = PressableConfiguration(pressScale: .medium)
    
    private var reward: Reward?

    private let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 18
        view.backgroundColor = Color.Primary.OffWhite
        view.layer.borderWidth = 1
        view.isSkeletonable = true
        return view
    }()
    
    private let rewardNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SFProTextRegular(size: 12)
        label.numberOfLines = 2
        return label
    }()
    
    private let rewardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
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
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 120, height: 150)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func apply(viewModel: ViewModel) {
        reward = viewModel.reward
        
        rewardNameLabel.text = viewModel.reward.title
        rewardImageView.image = viewModel.reward.image
        
        cardView.layer.borderColor = viewModel.isSelected ? Color.Primary.Black.cgColor : UIColor.clear.cgColor
    }
    
    func prepareForReuse() {
        // no - op
    }
    
}

private extension RewardComponent {
    func commonInit() {
        configureSubviews()
        configureLayout()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        addGestureRecognizer(tap)
    }
    
    func configureSubviews() {
        addSubview(cardView)
        cardView.addSubviews(rewardNameLabel, rewardImageView)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            rewardNameLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -Spacing.sixteen),
            rewardNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            rewardNameLabel.widthAnchor.constraint(equalToConstant: 80),
            
            rewardImageView.bottomAnchor.constraint(equalTo: rewardNameLabel.topAnchor, constant: -Spacing.eight),
            rewardImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            rewardImageView.heightAnchor.constraint(equalToConstant: 96),
            rewardImageView.widthAnchor.constraint(equalToConstant: 96)
        ])
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        if let reward = reward {
            actions?(.rewardSelected(reward))
        }
    }
    
}

//MARK: - Actionable

extension RewardComponent: Actionable {
    public typealias Actions = (Action) -> Void
    
    public enum Action {
        case rewardSelected(Reward)
    }
}
