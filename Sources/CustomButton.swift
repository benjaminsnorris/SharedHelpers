/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

@IBDesignable open class CustomButton: UIButton, CircularView, BackgroundColorNameable, TintColorNameable, BorderColorNameable, ShadowColorNameable, FontNameable {
    
    // MARK: - Inspectable properties
    
    @IBInspectable open var titleColorName: String? {
        didSet {
            updateTitleColor()
        }
    }
    
    @IBInspectable open var disabledTitleColorName: String? {
        didSet {
            updateDisabledTitleColor()
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
            guard let color = UIColor(withName: progressColorName) else { return }
            progressColor = color
        }
    }

    @IBInspectable open var shadowColorName: String? {
        didSet {
            applyShadowColorName()
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
            setTitle(title, for: UIControl.State.normal)
        }
    }
    
    @IBInspectable open var loading: Bool = false {
        didSet {
            if loading {
                spinner.color = titleColor(for: UIControl.State.normal)
                spinner.startAnimating()
                setTitle(nil, for: UIControl.State.normal)
                accessibilityLabel = NSLocalizedString("Loading", comment: "Label for button while loading")
            } else {
                spinner.stopAnimating()
                setTitle(title, for: UIControl.State.normal)
                accessibilityLabel = nil
            }
        }
    }
    
    @IBInspectable open var clearHighlight: Bool = false
    
    
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
    
    fileprivate let spinner = UIActivityIndicatorView(style: .white)
    fileprivate let progressLayer = CAShapeLayer()

    
    // MARK: - Initializers
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        registerForNotifications()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        registerForNotifications()
    }
    
    
    // MARK: - Lifecycle overrides
    
    open override var isHighlighted: Bool {
        didSet {
            guard clearHighlight else { return }
            if isHighlighted {
                backgroundColor = .clear
            } else {
                applyBackgroundColorName()
            }
        }
    }
    
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

    
    // MARK: - Functions
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateColors), name: Notification.Name.AppearanceColorsUpdated, object: nil)
    }
    
    @objc func updateColors() {
        updateTitleColor()
        updateDisabledTitleColor()
        applyBackgroundColorName()
        applyTintColorName()
        applyBorderColorName()
        applyShadowColorName()
    }
    
    func updateTitleColor() {
        setTitleColor(UIColor(withName: titleColorName), for: .normal)
    }
    
    func updateDisabledTitleColor() {
        setTitleColor(UIColor(withName: disabledTitleColorName), for: .disabled)
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
