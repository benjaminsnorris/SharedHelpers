/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

@IBDesignable open class CustomVisualEffectView: UIVisualEffectView, TintColorNameable {
    
    // MARK: - Inspectable properties
    
    @IBInspectable open var tintColorName: String? {
        didSet {
            applyTintColorName()
        }
    }

}
