/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

@IBDesignable open class CustomSearchBar: UISearchBar, TintColorNameable {
    
    // MARK: - Inspectable properties
    
    @IBInspectable open var barTintColorName: String? {
        didSet {
            updateColors()
        }
    }
    
    @IBInspectable open var tintColorName: String? {
        didSet {
            updateColors()
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
    
    public convenience init() {
        self.init(frame: .zero)
    }
    
    
    // MARK: - Functions
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateColors), name: Notification.Name.AppearanceColorsUpdated, object: nil)
    }
    
    func updateColors() {
        applyTintColorName()
        barTintColor = UIColor(withName: barTintColorName)
    }

}
