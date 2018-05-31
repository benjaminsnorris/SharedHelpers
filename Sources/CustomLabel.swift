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
    
    @IBInspectable open var useCapHeight: Bool = false {
        didSet {
            setNeedsLayout()
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

    override open var alignmentRectInsets: UIEdgeInsets {
        var insets = UIEdgeInsets.zero
        if useCapHeight, let scale = window?.screen.scale {
            insets.top = (ceil(font.lineHeight * scale) - ceil(-font.descender * scale) - round(font.capHeight * scale)) / scale
            insets.bottom = (ceil(font.lineHeight * scale) - ceil(-font.descender * scale) - round(font.capHeight * scale)) / scale
        }
        return insets
    }
    

    // MARK: - Functions
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateColors), name: Notification.Name.AppearanceColorsUpdated, object: nil)
    }
    
    @objc func updateColors() {
        updateTextColor()
    }
    
    func updateTextColor() {
        textColor = UIColor(withName: textColorName)
    }

}
