//
//  QuizOverviewComponent.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/7/21.
//

import UIKit
import SkeletonView

final class QuizOverviewComponent: UIView, Component, Pressable, Reusable {
    struct ViewModel {
        let quiz: Quiz
    }
    
    private var timer = Timer()
    public var actions: Actions?
    public let configuration = PressableConfiguration(pressScale: .medium)
    
    private var quiz: Quiz?

    private let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 18
        view.backgroundColor = Color.Primary.OffWhite
        view.isSkeletonable = true
        return view
    }()
    
    private let titleContentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.four
        return stackView
    }()
    
    private let quizNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SFProTextRegular(size: 12)
        label.textColor = Color.Primary.GrayText
        label.numberOfLines = 1
        return label
    }()
    
    private let rewardLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SFProTextSemibold(size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    private let launchTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Color.Primary.GrayText
        label.font = UIFont.SFProTextRegular(size: 12)
        label.text = "--h --m --s"
        label.numberOfLines = 1
        return label
    }()
    
    private let rewardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let launchButton: ButtonComponent = {
        let button = ButtonComponent()
        button.isUserInteractionEnabled = false
        return button
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
    
    func apply(viewModel: ViewModel) {
        quiz = viewModel.quiz
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeLabel), userInfo: nil, repeats: true)
        quizNameLabel.text = quiz?.quizName
        rewardLabel.text = quiz?.reward.title
        rewardImage.image = quiz?.reward.image
    }
    
    func prepareForReuse() {
        // no - op
    }
    
}

private extension QuizOverviewComponent {
    func commonInit() {
        configureSubviews()
        configureLayout()
        isSkeletonable = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        addGestureRecognizer(tap)
    }
    
    func configureSubviews() {
        addSubview(cardView)
        cardView.addSubviews(rewardImage, titleContentStack)
        titleContentStack.addArrangedSubviews(quizNameLabel, rewardLabel, launchTimeLabel, launchButton)
        
        titleContentStack.setCustomSpacing(Spacing.sixteen, after: rewardLabel)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleContentStack.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            titleContentStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Spacing.sixteen),
            titleContentStack.trailingAnchor.constraint(equalTo: rewardImage.leadingAnchor, constant: -Spacing.four),
            
            rewardImage.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            rewardImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.sixteen),
            rewardImage.heightAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.8),
            rewardImage.widthAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.8),
            
            launchButton.widthAnchor.constraint(equalTo: titleContentStack.widthAnchor, multiplier: 0.65),
            launchButton.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        if let quiz = quiz {
            actions?(.quizSelected(quiz))
        }
    }
    
    func countDownToLaunchText(launchTime: Double) -> String? {
        let currentDate = Date()
        let launchDate = Date(timeIntervalSince1970: launchTime)
        let calendar = Calendar.current

        let diffDateComponents = calendar.dateComponents([.hour, .minute, .second], from: currentDate, to: launchDate)
        if let hour = diffDateComponents.hour,
           let minute = diffDateComponents.minute,
           let seconds = diffDateComponents.second {
            return "\(hour)h \(minute)m \(seconds)s"
        }
        return nil
    }
    
    @objc func updateTimeLabel() {
        guard let quiz = quiz else { return }
        
        // If we are in between the launch and end
        if Date().timeIntervalSince1970 >= quiz.launchTime && Date().timeIntervalSince1970 <= quiz.endTime {
            launchTimeLabel.isHidden = true
            launchButton.isHidden = false
            launchButton.apply(viewModel: ButtonComponent.ViewModel(style: .primary, text: "Join"))
        }
        // We're past the launch date
        else if Date().timeIntervalSince1970 > quiz.endTime {
            launchTimeLabel.isHidden = true
            launchButton.isHidden = false
            launchButton.apply(viewModel: ButtonComponent.ViewModel(style: .primary, text: "Closed"))
            launchButton.isEnabled = false
        }
        else {
            launchTimeLabel.isHidden = false
            launchButton.isHidden = true
            launchTimeLabel.text = countDownToLaunchText(launchTime: quiz.launchTime)
        }
    }
}

//MARK: - Actionable

extension QuizOverviewComponent: Actionable {
    public typealias Actions = (Action) -> Void
    
    public enum Action {
        case quizSelected(Quiz)
    }
}
