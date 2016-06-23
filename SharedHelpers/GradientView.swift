/*
 |  _   ____   ____   _
 | ⎛ |‾|  ⚈ |-| ⚈  |‾| ⎞
 | ⎝ |  ‾‾‾‾| |‾‾‾‾  | ⎠
 |  ‾        ‾        ‾
 */

import UIKit

@IBDesignable public class GradientView: UIView {
    
    // MARK: - Enums
    
    enum Direction: Int {
        case Vertical
        case Horizontal
        case DiagonalDown
        case DiagonalUp
    }
    
    
    // MARK: - Inspectable properties
    
    @IBInspectable public var startColor: UIColor = .blueColor()
    @IBInspectable public var endColor: UIColor = .redColor()
    @IBInspectable public var direction: Int = 0
    
    
    // MARK: - Internal computed properties
    
    var computedDirection: Direction {
        guard let dir = Direction(rawValue: direction) else { return .Vertical }
        return dir
    }

    
    // MARK: - Private properties
    
    private let gradientLayer: CAGradientLayer
    
    
    // MARK: - Initializers
    
    required public init?(coder aDecoder: NSCoder) {
        gradientLayer = CAGradientLayer()
        super.init(coder: aDecoder)
        layer.addSublayer(gradientLayer)
    }
    
    override public init(frame: CGRect) {
        gradientLayer = CAGradientLayer()
        super.init(frame: frame)
        layer.addSublayer(gradientLayer)
    }
    
    
    // MARK: - Lifecycle overrides
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
        gradientLayer.colors = [startColor.CGColor, endColor.CGColor]
        
        var startPoint = CGPoint(x: 0.0, y: 0.0)
        var endPoint = CGPoint(x: 0.0, y: 1.0)
        switch computedDirection {
        case .Vertical:
            break
        case .Horizontal:
            startPoint = CGPoint(x: 0.0, y: 0.0)
            endPoint = CGPoint(x: 1.0, y: 0.0)
        case .DiagonalDown:
            startPoint = CGPoint(x: 0.0, y: 0.0)
            endPoint = CGPoint(x: 1.0, y: 1.0)
        case .DiagonalUp:
            startPoint = CGPoint(x: 0.0, y: 1.0)
            endPoint = CGPoint(x: 1.0, y: 0.0)
        }
        self.gradientLayer.startPoint = startPoint
        self.gradientLayer.endPoint = endPoint
    }
    
}
