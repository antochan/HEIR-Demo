//
//  SceneDelegate.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//


import UIKit

public enum PressScale: CGFloat {
    case large = 0.95
    case medium = 0.965
    case small = 0.98
    case none = 1.0
}

private enum Constants {
    static let animationDuration: TimeInterval = 0.2
}

public protocol PressScalable: AnyObject {
    func set(isScaled: Bool, scale: PressScale, isAnimated: Bool)
}

// MARK: - Public
public extension PressScalable where Self: UIView {
    func set(isScaled: Bool, scale: PressScale, isAnimated: Bool) {
        let scaleTransform = CGAffineTransform(scaleX: scale.rawValue, y: scale.rawValue)
        
        let actions = {
            self.transform = isScaled ? scaleTransform : .identity
        }
        
        if isAnimated {
            UIView.animate(withDuration: Constants.animationDuration, delay: 0.0, options: .curveEaseInOut, animations: actions)
        } else {
            actions()
        }
    }
}
