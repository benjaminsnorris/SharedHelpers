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
        case vertical
        case horizontal
        case diagonalDown
        case diagonalUp
    }
    
    
    // MARK: - Inspectable properties
    
    @IBInspectable public var startColor: UIColor = .blue
    @IBInspectable public var endColor: UIColor = .red
    @IBInspectable public var direction: Int = 0
    
    
    // MARK: - Internal computed properties
    
    var computedDirection: Direction {
        guard let dir = Direction(rawValue: direction) else { return .vertical }
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
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        
        var startPoint = CGPoint(x: 0.0, y: 0.0)
        var endPoint = CGPoint(x: 0.0, y: 1.0)
        switch computedDirection {
        case .vertical:
            break
        case .horizontal:
            startPoint = CGPoint(x: 0.0, y: 0.0)
            endPoint = CGPoint(x: 1.0, y: 0.0)
        case .diagonalDown:
            startPoint = CGPoint(x: 0.0, y: 0.0)
            endPoint = CGPoint(x: 1.0, y: 1.0)
        case .diagonalUp:
            startPoint = CGPoint(x: 0.0, y: 1.0)
            endPoint = CGPoint(x: 1.0, y: 0.0)
        }
        self.gradientLayer.startPoint = startPoint
        self.gradientLayer.endPoint = endPoint
    }
    
}
