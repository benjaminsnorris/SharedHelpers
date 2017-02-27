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
            onTintColor = UIColor(named: tintColorName)
        }
    }

}
