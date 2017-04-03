/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

public extension UIView {
    
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable public var borderColor: UIColor? {
        get {
            guard let CGColor = layer.borderColor else { return nil }
            return UIColor(cgColor: CGColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    
    // MARK: - Constraining full size 
    
    public struct Margins: OptionSet {
        
        public let rawValue: Int
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        public static let leading = Margins(rawValue: 1)
        public static let top = Margins(rawValue: 2)
        public static let trailing = Margins(rawValue: 4)
        public static let bottom = Margins(rawValue: 8)
        
        public static let all: Margins = [.leading, .top, .trailing, .bottom]
    }
    
    public func constrainFullSize(leading: CGFloat = 0, top: CGFloat = 0, trailing: CGFloat = 0, bottom: CGFloat = 0) {
        guard let _ = self.superview else { fatalError("\(self) has no superview") }
        constrainFullSize(insets: UIEdgeInsets(top: top, left: leading, bottom: bottom, right: trailing), margins: [])
    }
    
    public func constrainFullSize(insets: UIEdgeInsets = .zero, margins: Margins) {
        guard let superview = self.superview else { fatalError("\(self) has no superview") }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: margins.contains(.leading) ? superview.layoutMarginsGuide.leadingAnchor : superview.leadingAnchor, constant: insets.left).isActive = true
        self.topAnchor.constraint(equalTo: margins.contains(.top) ? superview.layoutMarginsGuide.topAnchor : superview.topAnchor, constant: insets.top).isActive = true
        self.trailingAnchor.constraint(equalTo: margins.contains(.trailing) ? superview.layoutMarginsGuide.trailingAnchor : superview.trailingAnchor, constant: -insets.right).isActive = true
        self.bottomAnchor.constraint(equalTo: margins.contains(.bottom) ? superview.layoutMarginsGuide.bottomAnchor : superview.bottomAnchor, constant: -insets.bottom).isActive = true
    }

}
