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
    
    @IBInspectable open var tapToDeselect: Bool = false

    
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
    
    
    // MARK: - Lifecycle overrides
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let result = super.hitTest(point, with: event)
        guard tapToDeselect else { return result }
        if result == self, let selected = indexPathForSelectedRow {
            deselectRow(at: selected, animated: true)
        }
        return result
    }
    
    
    // MARK: - Functions
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateColors), name: Notification.Name.AppearanceColorsUpdated, object: nil)
    }
    
    @objc func updateColors() {
        applyBackgroundColorName()
        updateSeparatorColor()
    }
    
    func updateSeparatorColor() {
        separatorColor = UIColor(withName: separatorColorName)
    }

}
