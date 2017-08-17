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
            applyBackgroundColorName()
        }
    }
    
    @IBInspectable open var textColorName: String? {
        didSet {
<<<<<<< Updated upstream
            updateTextColor()
=======
            applyTextColorName()
        }
    }
    
    @IBInspectable open var detailTextColorName: String? {
        didSet {
            applyTextColorName()
>>>>>>> Stashed changes
        }
    }
    
    @IBInspectable open var tintColorName: String? {
        didSet {
            applyTintColorName()
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
    
    
    // MARK: - Initializers
    
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        applyBackgroundColorName()
        applyTintColorName()
        applyTextColorName()
        detailTextLabel?.font = UIFont(named: detailFontName)
    }
    
<<<<<<< Updated upstream

    // MARK: - Functions
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateColors), name: Notification.Name.AppearanceColorsUpdated, object: nil)
    }
    
    func updateColors() {
        applyBackgroundColorName()
        applyTintColorName()
        updateTextColor()
    }
    
    func updateTextColor() {
        textLabel?.textColor = UIColor(named: textColorName)
    }

=======
    
    // MARK: - Internal functions
    
    func applyTextColorName() {
        textLabel?.textColor = UIColor(named: textColorName)
        detailTextLabel?.textColor = UIColor(named: detailTextColorName)
    }
    
>>>>>>> Stashed changes
}
