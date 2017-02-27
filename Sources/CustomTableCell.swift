/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

@IBDesignable open class CustomTableCell: UITableViewCell, BackgroundColorNameable, TintColorNameable, FontNameable {
    
    // MARK: - Inspectable properties
    
    @IBInspectable open var backgroundColorName: String? {
        didSet {
            let filledBackground = UIView()
            filledBackground.backgroundColor = UIColor(named: backgroundColorName)
            backgroundView = filledBackground
        }
    }
    
    @IBInspectable open var textColorName: String? {
        didSet {
            textLabel?.textColor = UIColor(named: textColorName)
        }
    }
    
    @IBInspectable open var tintColorName: String? {
        didSet {
            tintColor = UIColor(named: tintColorName)
        }
    }
    
    @IBInspectable open var fontName: String? {
        didSet {
            applyFontName()
        }
    }
    
    @IBInspectable open var detailFontName: String? {
        didSet {
            detailTextLabel?.font = UIFont(named: detailFontName)
        }
    }

    
    // MARK: - Computed properties
    
    open var displayFont: UIFont? {
        get {
            return textLabel?.font
        }
        set {
            textLabel?.font = newValue
        }
    }
    
    
    // MARK: - Lifecycle overrides
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        applyFontName()
        detailTextLabel?.font = UIFont(named: detailFontName)
    }
    
}
