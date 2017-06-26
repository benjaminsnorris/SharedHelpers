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
            backgroundColor = UIColor(named: backgroundColorName)
        }
    }
    
    @IBInspectable open var textColorName: String? {
        didSet {
            updateTextColor()
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
        detailTextLabel?.font = UIFont(named: detailFontName)
    }
    

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

}
