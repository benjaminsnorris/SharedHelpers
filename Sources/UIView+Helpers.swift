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

    /// Helper function to return adjust value for movement, allowing for
    /// specifying limits in all directions. This is typically not called directly.
    ///
    /// - Parameters:
    ///   - dx: Delta movement in horizontal direction.
    ///   - dy: Delta movement in vertical direction.
    ///   - maxX: Maximum allowed movement in positive horizontal direction.
    ///   - minX: Maximum allowed movement in negative horizontal direction.
    ///   - maxY: Maximum allowed movement in positive vertical direction.
    ///   - minY: Maximum allowed movement in negative vertical direction.
    ///   - coefficient: Multiplier for original delta to decrease speed of movement. Defaults to `0.5`.
    ///   - isDamped: Flag for moving exactly with touch (as modified by coefficient). Defaults to `true`.
    /// - Returns: Tuple with adjusted value in both directions that can be used to move view, such as with transform or constraint constant.
    public func adjusted(dx: CGFloat = 0, dy: CGFloat = 0, maxX: CGFloat = 0, minX: CGFloat = 0, maxY: CGFloat = 0, minY: CGFloat = 0, multiplyDeltaBy coefficient: CGFloat = 0.5, withDamping isDamped: Bool = true) -> (CGFloat, CGFloat) {
        let adjustedX = adjustedSingleValue(delta: dx, max: maxX, min: minX, multiplyDeltaBy: coefficient, withDamping: isDamped)
        let adjustedY = adjustedSingleValue(delta: dy, max: maxY, min: minY, multiplyDeltaBy: coefficient, withDamping: isDamped)
        return (adjustedX, adjustedY)
    }
    
    /// Helper function to return adjusted value for movement, allowing for
    /// passing in upper and lower limit, along with actual delta.
    ///
    /// - Note: Use a `min` of `0` to allow only positive movement, or use a
    /// `max` of `0` to allow only negative movement.
    ///
    /// - Parameters:
    ///   - delta: Actual movement amount, typically from scrolling or panning.
    ///   - max: Maximum allowed movement in positive direction.
    ///   - min: Maximum allowed movement in negative direction.
    ///   - coefficient: Multiplier for original delta to decrease speed of movement. Defaults to `0.5`.
    ///   - isDamped: Flag for moving exactly with touch (as modified by coefficient). Defaults to `true`.
    /// - Returns: Adjusted value that can be used to move view, such as with transform or constraint constant.
    public func adjustedSingleValue(delta: CGFloat, max: CGFloat, min: CGFloat, multiplyDeltaBy coefficient: CGFloat = 0.5, withDamping isDamped: Bool = true) -> CGFloat {
        if delta >= 0 {
            return adjustedSingleValue(delta: delta, extreme: max, multiplyDeltaBy: coefficient, withDamping: isDamped)
        }
        return adjustedSingleValue(delta: delta, extreme: min, multiplyDeltaBy: coefficient, withDamping: isDamped)
    }
    
    /// Function to return adjusted value based on movement as adjusted by
    /// damping equation. Usually not called directly
    ///
    /// - Parameters:
    ///   - delta: Actual movement amount, typically from scrolling or panning.
    ///   - extreme: Minimum or maximum allowed movement. Should be a positive value.
    ///   - coefficient: Multiplier for original delta to decrease speed of movement. Defaults to `0.5`.
    ///   - isDamped: Flag for moving exactly with touch (as modified by coefficient). Defaults to `true`.
    /// - Returns: Adjusted value that can be used to move view, such as with transform or constraint constant.
    public func adjustedSingleValue(delta: CGFloat, extreme: CGFloat, multiplyDeltaBy coefficient: CGFloat = 0.5, withDamping isDamped: Bool = true) -> CGFloat {
        guard extreme != 0 else { return 0 }
        let adjustedDelta = abs(delta * coefficient)
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
    
    /// Use transform to move view based on panning. Can be used for panning to reveal
    /// or trigger actions.
    ///
    /// - Parameters:
    ///   - recognizer: Pan gesture recognizer triggering the movement
    ///   - maxX: Upper positive limit of horizontal movement. Defaults to `0`.
    ///   - minX: Lower negative limit of horizontal movement. Defaults to `0`.
    ///   - maxY: Upper positive limit of vertical movement. Defaults to `0`.
    ///   - minY: Lower negative limit of vertical movement. Defaults to `0`.
    ///   - coefficient: Multiplier for original delta to decrease speed of movement. Defaults to `0.5`.
    ///   - isDamped: Flag for moving exactly with touch (as modified by coefficient). Defaults to `true`.
    public func adjust(for recognizer: UIPanGestureRecognizer, maxX: CGFloat = 0, minX: CGFloat = 0, maxY: CGFloat = 0, minY: CGFloat = 0, multiplyDeltaBy coefficient: CGFloat = 0.5, withDamping isDamped: Bool = true) {
        switch recognizer.state {
        case .began:
            resetAdjustment()
        case .changed:
            let (dx, dy) = adjusted(dx: recognizer.translation(in: superview).x, dy: recognizer.translation(in: superview).y, maxX: maxX, minX: minX, maxY: maxY, minY: minY, multiplyDeltaBy: coefficient, withDamping: isDamped)
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
