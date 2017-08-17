/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

@IBDesignable open class CustomTableView: UITableView, BackgroundColorNameable {
    
    // MARK: - Inspectable properties

    @IBInspectable open var backgroundColorName: String? {
        didSet {
            applyBackgroundColorName()
        }
    }
    
    @IBInspectable open var separatorColorName: String? {
        didSet {
            updateSeparatorColor()
        }
    }

    
    // MARK: - Initializers
    
    override public init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        registerForNotifications()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        registerForNotifications()
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        updateSeparatorColor()
    }
    
    
    // MARK: - Functions
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateColors), name: Notification.Name.AppearanceColorsUpdated, object: nil)
    }
    
    func updateColors() {
        applyBackgroundColorName()
        updateSeparatorColor()
    }
    
    func updateSeparatorColor() {
        separatorColor = UIColor(named: separatorColorName)
    }

}
