//
//  HuddleView.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit
import Hero

final class HuddleView: UIView {
    
    let lameloBallCard: AthleteBannerComponent = {
        let component = AthleteBannerComponent()
        component.translatesAutoresizingMaskIntoConstraints = false
        component.configuration = PressableConfiguration(pressScale: .none)
        component.hero.id = "LameloCard"
        component.apply(viewModel: AthleteBannerComponent.ViewModel(bannerImage: #imageLiteral(resourceName: "lameloBanner"),
                                                                    athleteFirstName: "Lamelo",
                                                                    athleteLastName: "Ball",
                                                                    teamName: "Charlotte Hornets"))
        return component
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Color.Primary.Black
        button.tintColor = Color.Primary.White
        button.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: Spacing.eight, left: Spacing.eight, bottom: Spacing.eight, right: Spacing.eight)
        button.layer.cornerRadius = 12.5
        button.clipsToBounds = true
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

private extension HuddleView {
    
    func commonInit() {
        backgroundColor = Color.Primary.White
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(lameloBallCard, closeButton)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            lameloBallCard.topAnchor.constraint(equalTo: topAnchor),
            lameloBallCard.centerXAnchor.constraint(equalTo: centerXAnchor),
            lameloBallCard.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.525),
            lameloBallCard.widthAnchor.constraint(equalTo: widthAnchor),
            
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Spacing.sixteen),
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.twentyFour),
            closeButton.heightAnchor.constraint(equalToConstant: 25),
            closeButton.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
    
}
