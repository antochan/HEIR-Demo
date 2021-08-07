//
//  Constants.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit

public enum Spacing {
    public static let zero: CGFloat = 0
    public static let four: CGFloat = 4
    public static let eight: CGFloat = 8
    public static let twelve: CGFloat = 12
    public static let sixteen: CGFloat = 16
    public static let twentyFour: CGFloat = 24
    public static let thirtyTwo: CGFloat = 32
    public static let forty: CGFloat = 40
    public static let fortyEight: CGFloat = 48
}

public struct CornerRadius {
    public enum Style {
        /// 12pt corner radius
        case large
        /// 6pt corner radius
        case small
        /// 3pt corner radius
        case tiny
        /// 0pt corner radius
        case none
        /// Calculcates the corner radius based on the one half of the `height` of the `bounds`
        case circular
        public func value(forBounds bounds: CGRect) -> CGFloat {
            switch self {
            case .large:
                return 12.0
            case .small:
                return 6.0
            case .tiny:
                return 3.0
            case .none:
                return 0.0
            case .circular:
                return bounds.height / 2.0
            }
        }
    }
    
    public let style: Style
    public let cornerMasks: CACornerMask
    public let rectCorners: UIRectCorner
    
    public init(style: Style, cornerMasks: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]) {
        self.style = style
        self.cornerMasks = cornerMasks
        rectCorners = UIRectCorner.make(withCornerMasks: cornerMasks)
    }
}

// MARK: - UIRectCorner
private extension UIRectCorner {
    static func make(withCornerMasks cornerMasks: CACornerMask) -> UIRectCorner {
        var rectCorners = UIRectCorner()
        
        if cornerMasks.contains(.layerMinXMinYCorner) {
            rectCorners.insert(.topLeft)
        }
        
        if cornerMasks.contains(.layerMaxXMinYCorner) {
            rectCorners.insert(.topRight)
        }
        
        if cornerMasks.contains(.layerMinXMaxYCorner) {
            rectCorners.insert(.bottomLeft)
        }
        
        if cornerMasks.contains(.layerMaxXMaxYCorner) {
            rectCorners.insert(.bottomRight)
        }
        
        return rectCorners
    }
}

public enum BorderWidth: CGFloat {
    case normal = 1.0
    case thin = 0.5
    case none = 0.0
}

struct Color {
    
    struct Primary {
        static let Black = UIColor(rgb: 0x000000)
        static let White = UIColor(rgb: 0xFFFFFF)
        static let GrayText = UIColor(rgb: 0x8F92A1)
        static let BackgroundWhite = UIColor(rgb: 0xF5F5F5)
        static let LightGray = UIColor(rgb: 0xBDBDBD)
        static let DarkGray = UIColor(rgb: 0xC4C4C4)
    }
}
