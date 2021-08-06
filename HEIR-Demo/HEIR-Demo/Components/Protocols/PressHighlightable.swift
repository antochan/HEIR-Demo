//
//  SceneDelegate.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//


import UIKit

public enum HighlightMargin: CGFloat {
    case eight = 8.0
    case none = 0.0
}

private enum Constants {
    static let animationDuration: TimeInterval = 0.2
    static let highlightAlpha: CGFloat = 0.1
    static let highlightColor = UIColor.lightGray.withAlphaComponent(0)
}

public protocol PressHighlightable: AnyObject {
    func set(isHighlighted: Bool, margin: HighlightMargin, isAnimated: Bool)
}

// MARK: - Public
public extension PressHighlightable where Self: UIView {
    func set(isHighlighted: Bool, margin: HighlightMargin, isAnimated: Bool) {
        let highlightView = currentHighlightView
        
        if isHighlighted {
            highlightView.frame = bounds.insetBy(dx: -margin.rawValue, dy: -margin.rawValue)
            highlightView.layer.cornerRadius = layer.cornerRadius
        } else {
            highlightView.removeFromSuperview()
        }
        
        let alpha = isHighlighted ? Constants.highlightAlpha : 0.0
        
        let actions = {
            highlightView.alpha = alpha
        }
        
        let completion = { (didFinish: Bool) in
            if isHighlighted == false && didFinish {
                highlightView.removeFromSuperview()
            }
        }
        
        if isAnimated {
            UIView.animate(withDuration: Constants.animationDuration, delay: 0.0, options: .curveEaseInOut, animations: actions, completion: completion)
        } else {
            actions()
            completion(true)
        }
    }
}

// MARK: - Private
private extension PressHighlightable where Self: UIView {
    var currentHighlightView: UIView {
        if let view = subviews.first(where: { $0 is HighlightView }) {
            return view
        } else {
            let view = HighlightView(frame: .zero)
            addSubview(view)
            return view
        }
    }
}

// MARK: - HighlightView
private class HighlightView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Constants.highlightColor
        alpha = 0.0
        clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
