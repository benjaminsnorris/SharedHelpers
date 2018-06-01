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
    
    @IBInspectable public var shadowColor: UIColor? {
        get {
            guard let CGColor = layer.shadowColor else { return nil }
            return UIColor(cgColor: CGColor)
        }
        set {
            layer.shadowColor = newValue?.cgColor
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

    public func adjusted(dx: CGFloat = 0, dy: CGFloat = 0, maxX: CGFloat = 0, minX: CGFloat = 0, maxY: CGFloat = 0, minY: CGFloat = 0, withDamping isDamped: Bool = true) -> (CGFloat, CGFloat) {
        let adjustedX = adjustedSingleValue(delta: dx, max: maxX, min: minX, withDamping: isDamped)
        let adjustedY = adjustedSingleValue(delta: dy, max: maxY, min: minY, withDamping: isDamped)
        return (adjustedX, adjustedY)
    }
    
    public func adjustedSingleValue(delta: CGFloat, max: CGFloat, min: CGFloat, withDamping isDamped: Bool = true) -> CGFloat {
        if delta >= 0 {
            return adjustedSingleValue(delta: delta, extreme: max, withDamping: isDamped)
        }
        return adjustedSingleValue(delta: delta, extreme: min, withDamping: isDamped)
    }
    
    public func adjustedSingleValue(delta: CGFloat, extreme: CGFloat, withDamping isDamped: Bool = true) -> CGFloat {
        guard extreme != 0 else { return 0 }
        let adjustedDelta = abs(delta)
        let extremeHalf = abs(extreme) / 2.0
        let adjustedExtreme = isDamped ? abs(extremeHalf) : abs(extreme)
        var adjusted = min(adjustedDelta, adjustedExtreme)
        if isDamped && adjustedDelta > extremeHalf {
            let extra = adjustedDelta - extremeHalf
            let multiplierExtra = extremeHalf - ((extremeHalf / (extremeHalf + extra)) * extra)
            let multiplier = multiplierExtra / extremeHalf
            adjusted += multiplier * extra
        }
        return delta >= 0 ? adjusted : -adjusted
    }
    
    public func adjust(for recognizer: UIPanGestureRecognizer, maxX: CGFloat = 0, minX: CGFloat = 0, maxY: CGFloat = 0, minY: CGFloat = 0, withDamping isDamped: Bool = true) {
        switch recognizer.state {
        case .began:
            resetAdjustment()
        case .changed:
            let (dx, dy) = adjusted(dx: recognizer.translation(in: superview).x, dy: recognizer.translation(in: superview).y, maxX: maxX, minX: minX, maxY: maxY, minY: minY, withDamping: isDamped)
            transform = CGAffineTransform(translationX: dx, y: dy)
        case .ended:
            UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: {
                self.resetAdjustment()
            }, completion: nil)
        case .cancelled, .failed:
            resetAdjustment()
        case .possible:
            break
        }
    }
    
    fileprivate func resetAdjustment() {
        transform = .identity
    }

}
