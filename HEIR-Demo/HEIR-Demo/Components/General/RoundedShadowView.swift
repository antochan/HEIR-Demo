//
//  RoundedShadowView.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/8/21.
//

import UIKit

class RoundedShadowView: UIView {
    let containerView = UIView()
    let cornerRadius: CGFloat = 6.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layoutView()
    }
    
    func layoutView() {

        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4.0)
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 4.0
        
        containerView.layer.cornerRadius = cornerRadius
        containerView.layer.masksToBounds = true
        
        addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
