//
//  QuizResultView.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit
import SkeletonView

final class QuizResultView: UIView {
    
    let backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "Glass")
        return imageView
    }()
    
    let backgroundOverlay: UIView = {
        let overlay = UIView()
        overlay.translatesAutoresizingMaskIntoConstraints = false
        overlay.backgroundColor = Color.Primary.Black.withAlphaComponent(0.6)
        return overlay
    }()
    
    let rewardTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SFProTextRegular(size: 15)
        label.numberOfLines = 0
        label.textColor = Color.Primary.White.withAlphaComponent(0.8)
        return label
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = Color.Primary.White
        button.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: Spacing.eight, left: Spacing.eight, bottom: Spacing.eight, right: Spacing.eight)
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.eight
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let quizCompleteStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private let quizCompleteTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProTextRegular(size: 13)
        label.textColor = Color.Primary.White.withAlphaComponent(0.8)
        label.text = "Quiz Complete"
        return label
    }()
    
    let fanNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProTextRegular(size: 15)
        label.textColor = Color.Primary.White
        return label
    }()
    
    let leaderboardStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.four
        return stackView
    }()
    
    private let leaderboardTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProTextMedium(size: 14)
        label.textColor = Color.Primary.White
        label.text = "Leaderboard"
        return label
    }()
    
    let leadersStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.four
        return stackView
    }()
    
    private let performanceStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.four
        stackView.isSkeletonable = true
        return stackView
    }()
    
    private let performanceTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.Primary.White
        label.font = UIFont.SFProTextMedium(size: 14)
        label.text = "Performance Report:"
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.Primary.White
        label.font = UIFont.SFProTextMedium(size: 13)
        label.text = "Dummy Score Label"
        label.isSkeletonable = true
        return label
    }()
    
    let averageElapsedTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.Primary.White
        label.font = UIFont.SFProTextRegular(size: 13)
        label.text = "Dummy average elapsed time label"
        label.isSkeletonable = true
        return label
    }()
    
    let quizSolutionResultStack: UIStackView = {
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

}

private extension QuizResultView {
    
    func commonInit() {
        backgroundColor = Color.Primary.White
        configureSubviews()
        configureLayout()
        
        isSkeletonable = true
    }
    
    func configureSubviews() {
        addSubviews(backgroundView, backgroundOverlay, closeButton, rewardTitleLabel, scrollView)
        scrollView.addSubview(contentStackView)
        contentStackView.addArrangedSubviews(quizCompleteStack, leaderboardStack, performanceStack)
        
        quizCompleteStack.addArrangedSubviews(quizCompleteTitleLabel, fanNameLabel)
        leaderboardStack.addArrangedSubviews(leaderboardTitleLabel, leadersStack)
        performanceStack.addArrangedSubviews(performanceTitleLabel, scoreLabel, averageElapsedTimeLabel, quizSolutionResultStack)
        
        contentStackView.setCustomSpacing(Spacing.fortyEight, after: quizCompleteStack)
        contentStackView.setCustomSpacing(Spacing.forty, after: leaderboardStack)
        
        performanceStack.setCustomSpacing(Spacing.eight, after: performanceTitleLabel)
        performanceStack.setCustomSpacing(2.0, after: scoreLabel)
        performanceStack.setCustomSpacing(Spacing.sixteen, after: averageElapsedTimeLabel)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            backgroundOverlay.topAnchor.constraint(equalTo: topAnchor),
            backgroundOverlay.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundOverlay.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundOverlay.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            rewardTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Spacing.sixteen),
            rewardTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Spacing.sixteen),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            closeButton.heightAnchor.constraint(equalToConstant: 25),
            closeButton.widthAnchor.constraint(equalToConstant: 25),
            
            scrollView.topAnchor.constraint(equalTo: rewardTitleLabel.bottomAnchor, constant: Spacing.twentyFour),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.twentyFour),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Spacing.thirtyTwo),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }
    
}
