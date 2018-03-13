/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

@IBDesignable open class CustomSwitch: UISwitch, TintColorNameable {
    
    // MARK: - Inspectable properties
    
    @IBInspectable open var tintColorName: String? {
        didSet {
            applyTintColorName()
        }
    }
    
    @IBInspectable open var onTintColorName: String? {
        didSet {
            updateOnTint()
        }
    }
    
    @IBInspectable open var thumbColorName: String? {
        didSet {
            updateThumbTint()
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
    
    @objc func updateColors() {
        applyTintColorName()
        updateOnTint()
        updateThumbTint()
    }
    
    func updateOnTint() {
        onTintColor = UIColor(withName: onTintColorName)
    }

    func updateThumbTint() {
        thumbTintColor = UIColor(withName: thumbColorName)
    }

}
