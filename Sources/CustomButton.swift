/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

@IBDesignable open class CustomButton: UIButton, CircularView, BackgroundColorNameable, TintColorNameable, BorderColorNameable, FontNameable {
    
    // MARK: - Inspectable properties
    
    @IBInspectable open var titleColorName: String? {
        didSet {
            setTitleColor(UIColor(named: titleColorName), for: .normal)
        }
    }
    
    @IBInspectable open var disabledTitleColorName: String? {
        didSet {
            setTitleColor(UIColor(named: disabledTitleColorName), for: .disabled)
        }
    }
    
    @IBInspectable open var backgroundColorName: String? {
        didSet {
            applyBackgroundColorName()
        }
    }
    
    @IBInspectable open var tintColorName: String? {
        didSet {
            applyTintColorName()
        }
    }
    
    @IBInspectable open var borderColorName: String? {
        didSet {
            applyBorderColorName()
        }
    }
    
    @IBInspectable open var progressColorName: String? {
        didSet {
            guard let color = UIColor(named: progressColorName) else { return }
            progressColor = color
        }
    }
    
    @IBInspectable open var fontName: String? {
        didSet {
            applyFontName()
        }
    }
    
    @IBInspectable open var progress: Double = 0.0 {
        didSet {
            progressLayer.strokeEnd = CGFloat(progress)
        }
    }
    
    @IBInspectable open var progressColor: UIColor = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)  {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    @IBInspectable open var circular: Bool = false {
        didSet {
            layoutSubviews()
        }
    }
    
    @IBInspectable open var title: String? {
        didSet {
            setTitle(title, for: UIControlState.normal)
        }
    }
    
    @IBInspectable open var loading: Bool = false {
        didSet {
            if loading {
                spinner.color = titleColor(for: UIControlState.normal)
                spinner.startAnimating()
                setTitle(nil, for: UIControlState.normal)
                accessibilityLabel = NSLocalizedString("Loading", comment: "Label for button while loading")
            } else {
                spinner.stopAnimating()
                setTitle(title, for: UIControlState.normal)
                accessibilityLabel = nil
            }
        }
    }
    
    
    // MARK: - Computed properties
    
    open var displayFont: UIFont? {
        get {
            return titleLabel?.font
        }
        set {
            titleLabel?.font = newValue
        }
    }
    
    
    // MARK: - Private properties
    
    fileprivate let spinner = UIActivityIndicatorView(activityIndicatorStyle: .white)
    fileprivate let progressLayer = CAShapeLayer()

    
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
        applyCircularStyleIfNeeded()
        
        progressLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        let rotation = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        let translate = CATransform3DMakeTranslation(0, bounds.height, 0)
        progressLayer.transform = CATransform3DConcat(rotation, translate)
        progressLayer.lineWidth = bounds.height
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        applyFontName()
    }

}


// MARK: - Private properties

private extension CustomButton {
    
    func setupViews() {
        addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        spinner.stopAnimating()
        
        layer.addSublayer(progressLayer)
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeStart = 0.0
        progressLayer.strokeEnd = 0.0
        progressLayer.strokeColor = progressColor.cgColor
    }
    
}
