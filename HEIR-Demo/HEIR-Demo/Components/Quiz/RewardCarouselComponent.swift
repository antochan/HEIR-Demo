//
//  RewardCarouselComponent.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/7/21.
//

import UIKit

protocol RewardCarouselDelegate: AnyObject {
    func rewardSelected(_ reward: Reward)
}

final class RewardCarouselComponent: UIView {
    weak var delegate: RewardCarouselDelegate?
    
    var selectedReward: Reward? {
        didSet {
            renderRewardCarousel()
        }
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Spacing.sixteen
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func generateRewardComponent(reward: Reward) -> RewardComponent {
        let component = RewardComponent()
        component.apply(viewModel: RewardComponent.ViewModel(reward: reward, isSelected: selectedReward == reward))
        component.actions = { [weak self] action in
            switch action {
            case .rewardSelected(let reward):
                self?.delegate?.rewardSelected(reward)
                self?.selectedReward = reward
            }
        }
        return component
    }
    
    func renderRewardCarousel() {
        contentStackView.removeAllArrangedSubviews()
        
        Reward.allCases.forEach {
            contentStackView.addArrangedSubviews(generateRewardComponent(reward: $0))
        }
    }
    
}

private extension RewardCarouselComponent {
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        
        Reward.allCases.forEach {
            contentStackView.addArrangedSubviews(generateRewardComponent(reward: $0))
        }
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
}
