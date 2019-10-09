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
            applyTextColorNames()
        }
    }
    
    @IBInspectable open var detailTextColorName: String? {
        didSet {
            applyTextColorNames()
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
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        registerForNotifications()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        registerForNotifications()
    }
    
    
    // MARK: - Functions
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateColors), name: Notification.Name.AppearanceColorsUpdated, object: nil)
    }
    
    @objc func updateColors() {
        applyBackgroundColorName()
        applyTintColorName()
        applyTextColorNames()
    }
    
    func applyTextColorNames() {
        textLabel?.textColor = UIColor(withName: textColorName)
        detailTextLabel?.textColor = UIColor(withName: detailTextColorName)
    }
    
}
