/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

@IBDesignable open class CustomBasicTabBar: UITabBar, TintColorNameable {
    
    // MARK: - Inspectable properties
    
    @IBInspectable open var tintColorName: String? {
        didSet {
            applyTintColorName()
        }
    }
    
    @IBInspectable open var unselectedItemTintColorName: String? {
        didSet {
            applyUnselectedItemTintColor()
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
    
    
    // MARK: - Functions
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateColors), name: Notification.Name.AppearanceColorsUpdated, object: nil)
    }
    
    func updateColors() {
        applyTintColorName()
        applyUnselectedItemTintColor()
    }
    
    func applyUnselectedItemTintColor() {
        if #available(iOSApplicationExtension 10.0, *) {
            unselectedItemTintColor = UIColor(named: unselectedItemTintColorName)
        }
    }

}
