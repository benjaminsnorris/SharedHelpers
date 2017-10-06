/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

@IBDesignable open class CustomLabel: UILabel, FontNameable {
    
    // MARK: - Inspectable properties
    
    @IBInspectable open var textColorName: String? = "primaryText" {
        didSet {
            updateTextColor()
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
    
    func updateColors() {
        updateTextColor()
    }
    
    func updateTextColor() {
        textColor = UIColor(withName: textColorName)
    }

}
