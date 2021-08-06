//
//  SceneDelegate.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//


import UIKit

/// Any Object can conform to this protocol to add a pressable state. The default implementation is provided for UIViews.
/// In order to simulate the pressable state, the caller can call the default `set` function implemented in the pressable protocol.
/// The default `set` implementation will create an overlay over the designated view and simulate a press animation (if on).
public protocol Pressable: PressScalable, PressHighlightable {
    /// The configuration for the `Pressable`
    var configuration: PressableConfiguration { get }
    /// Changes the state of the `Pressable`
    func set(isPressed: Bool, animated: Bool)
}

/// The configuration for a `Pressable`
public struct PressableConfiguration {
    /// The scale at which the button changes when in the pressed state
    public let pressScale: PressScale
    /// The margin applied to the highlight state
    public let highlightMargin: HighlightMargin
    
    public init(pressScale: PressScale,
                highlightMargin: HighlightMargin = .none) {
        self.pressScale = pressScale
        self.highlightMargin = highlightMargin
    }
}

// MARK: - Public
public extension Pressable where Self: UIView {
    /// Turns the pressed state on/off with/without animation
    ///
    /// - Parameters:
    ///   - isPressed: pressed state of the view
    ///   - animated: Whether the press is animated
    func set(isPressed: Bool,
             animated: Bool) {
        set(isPressed: isPressed,
            animated: animated,
            pressScale: configuration.pressScale,
            highlightMargin: configuration.highlightMargin)
    }
}

// MARK: - Private
private extension Pressable where Self: UIView {
    func set(isPressed: Bool,
             animated: Bool,
             pressScale: PressScale,
             highlightMargin: HighlightMargin) {
        set(isHighlighted: isPressed, margin: highlightMargin, isAnimated: animated)
        set(isScaled: isPressed, scale: pressScale, isAnimated: animated)
    }
}
