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
            textColor = UIColor(named: textColorName)
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
    
    
    // MARK: - Lifecycle overrides
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        applyFontName()
    }

}
