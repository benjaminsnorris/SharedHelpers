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
    
    @IBInspectable open var fontName: String? {
        didSet {
            applyFontName()
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
    
    
    // MARK: - Initializers
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        arrangeSpinner()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        arrangeSpinner()
    }
    
    
    // MARK: - Lifecycle overrides
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        applyCircularStyleIfNeeded()
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        applyFontName()
    }

}


// MARK: - Private properties

private extension CustomButton {
    
    func arrangeSpinner() {
        addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        spinner.stopAnimating()
    }
    
}
