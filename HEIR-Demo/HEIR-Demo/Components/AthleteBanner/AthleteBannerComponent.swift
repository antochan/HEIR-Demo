//
//  AthleteBannerComponent.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/8/21.
//

import UIKit

final class AthleteBannerComponent: UIView, Component, Pressable {
    struct ViewModel {
        let bannerImage: UIImage // would be URL when API ready
        let athleteFirstName: String
        let athleteLastName: String
        let teamName: String
    }
    
    public var actions: Actions?
    public let configuration = PressableConfiguration(pressScale: .medium)
    
    private let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.backgroundColor = Color.Primary.OffWhite
        view.isSkeletonable = true
        return view
    }()
    
    private let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let teamNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.SFProTextLight(size: 12)
        label.textAlignment = .right
        return label
    }()
    
    private let athleteNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Futura-Bold", size: 22)
        label.textAlignment = .right
        label.numberOfLines = 0
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
    
    func apply(viewModel: ViewModel) {
        bannerImageView.image = viewModel.bannerImage
        athleteNameLabel.text = "\(viewModel.athleteFirstName)\n\(viewModel.athleteLastName)"
        teamNameLabel.text = "\(viewModel.teamName)'"
    }
    
}

private extension AthleteBannerComponent {
    func commonInit() {
        configureSubviews()
        configureLayout()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        addGestureRecognizer(tap)
    }
    
    func configureSubviews() {
        addSubview(cardView)
        cardView.addSubviews(bannerImageView, teamNameLabel, athleteNameLabel)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            bannerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bannerImageView.heightAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.95),
            bannerImageView.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.65),
            bannerImageView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            
            athleteNameLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            athleteNameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Spacing.thirtyTwo),
            
            teamNameLabel.bottomAnchor.constraint(equalTo: athleteNameLabel.topAnchor, constant: -Spacing.eight),
            teamNameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Spacing.thirtyTwo),
        ])
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        actions?(.athleteSelected(LameloBallUID))
    }
}

//MARK: - Actionable

extension AthleteBannerComponent: Actionable {
    public typealias Actions = (Action) -> Void
    
    public enum Action {
        // For now we are just passing a fixed Lamelo Ball ID. Future would be athlete's UID.
        case athleteSelected(String)
    }
}
