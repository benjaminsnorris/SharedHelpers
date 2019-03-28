/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

@IBDesignable open class CustomTextField: UITextField, TintColorNameable, FontNameable, BackgroundColorNameable {
    
    // MARK: - Inspectable properties
    
    @IBInspectable open var backgroundColorName: String? {
        didSet {
            applyBackgroundColorName()
        }
    }
    
    @IBInspectable open var textColorName: String? {
        didSet {
            updateTextColor()
        }
    }
    
    @IBInspectable open var tintColorName: String? {
        didSet {
            applyTintColorName()
        }
    }
    
    @IBInspectable open var placeholderTextColorName: String? {
        didSet {
            updatePlaceholderTextColor()
        }
    }
    
    @IBInspectable open var fontName: String? {
        didSet {
            applyFontName()
        }
    }
    
    
    // MARK: - Computed properties
    
    open var displayFont: UIFont? {
        get {
            return font
        }
        set {
            font = newValue
        }
    }
    
    
    // MARK: - Initializers
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        registerForNotifications()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        registerForNotifications()
    }
    
    
    // MARK: - Lifecycle overrides
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        applyFontName()
    }
    

    // MARK: - Functions
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateColors), name: Notification.Name.AppearanceColorsUpdated, object: nil)
    }
    
    @objc func updateColors() {
        applyBackgroundColorName()
        applyTintColorName()
        updateTextColor()
    }
    
    func updateTextColor() {
        textColor = UIColor(withName: textColorName)
    }
    
    func updatePlaceholderTextColor() {
        guard let placeholderText = placeholder, let placeholderColor = UIColor(withName: placeholderTextColorName) else { return }
        let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        self.attributedPlaceholder = attributedPlaceholder
    }

}
