/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

@IBDesignable open class SegmentedLine: CustomView {
    
    // MARK: - Inspectable properties
    
    @IBInspectable open var fillColorName: String? {
        didSet {
            updateColors()
        }
    }
    
    @IBInspectable open var fillBackgroundColorName: String? {
        didSet {
            updateColors()
        }
    }
    
    @IBInspectable open var fillColor: UIColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1) {
        didSet {
            updateColors()
        }
    }
    
    @IBInspectable open var fillBackgroundColor: UIColor = .white {
        didSet {
            updateColors()
        }
    }
    
    @IBInspectable open var segments: Int = 3 {
        didSet {
            updateBar()
        }
    }
    
    @IBInspectable open var segmentSpacing: CGFloat = 2 {
        didSet {
            updateBar()
        }
    }
    
    @IBInspectable open var progress: Float = 0.5 {
        didSet {
            barLayer.strokeEnd = CGFloat(progress)
        }
    }
    
    
    // MARK: - Private properties
    
    fileprivate let backgroundLayer = CAShapeLayer()
    fileprivate let barLayer = CAShapeLayer()
    
    
    // MARK: - Initializers
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    
    // MARK: - Lifecycle overrides
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        updateBar()
    }
    
    
    // MARK: - Functions
    
    override func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateColors), name: Notification.Name.AppearanceColorsUpdated, object: nil)
    }
    
    override func updateColors() {
        super.updateColors()
        if let fillColorName = fillColorName, let color = UIColor(withName: fillColorName) {
            barLayer.strokeColor = color.cgColor
        } else {
            barLayer.strokeColor = fillColor.cgColor
        }
        if let fillBackgroundName = fillBackgroundColorName, let color = UIColor(withName: fillBackgroundName) {
            backgroundLayer.strokeColor = color.cgColor
        } else {
            backgroundLayer.strokeColor = fillBackgroundColor.cgColor
        }
    }
    
}


// MARK: - Private functions

private extension SegmentedLine {
    
    func setupViews() {
        registerForNotifications()
        layoutIfNeeded()
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(barLayer)
        barLayer.strokeStart = 0.0
        barLayer.strokeEnd = CGFloat(progress)
        updateBar()
        updateColors()
    }
    
    func updateBar() {
        let start = CGPoint(x: frame.minX, y: frame.midY)
        let end = CGPoint(x: frame.maxX, y: frame.midY)
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        barLayer.path = path.cgPath
        backgroundLayer.path = path.cgPath
        let lineWidth = frame.height
        barLayer.lineWidth = lineWidth
        backgroundLayer.lineWidth = lineWidth
        
        let totalSpacing = segmentSpacing * CGFloat(segments - 1)
        let segmentLength = (frame.width - totalSpacing) / CGFloat(segments)
        let lineDashPattern = [NSNumber(value: Float(segmentLength)), NSNumber(value: Float(segmentSpacing))]
        backgroundLayer.lineDashPattern = lineDashPattern
        barLayer.lineDashPattern = lineDashPattern
    }
    
}
