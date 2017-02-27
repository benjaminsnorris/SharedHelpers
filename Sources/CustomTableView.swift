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
            separatorColor = UIColor(named: separatorColorName)
        }
    }

}
