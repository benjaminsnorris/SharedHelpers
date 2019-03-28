/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

@IBDesignable open class CustomActivityIndicator: UIActivityIndicatorView {
    
    // MARK: - Inspectable properties
    
    @IBInspectable open var colorName: String? {
        didSet {
            updateColors()
        }
    }
    
    // MARK: - Initializers
    
    override public init(style: UIActivityIndicatorView.Style) {
        super.init(style: style)
        registerForNotifications()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        registerForNotifications()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        registerForNotifications()
    }
    
    
    // MARK: - Functions
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateColors), name: Notification.Name.AppearanceColorsUpdated, object: nil)
    }
    
    @objc func updateColors() {
        color = UIColor(withName: colorName)
    }

}
