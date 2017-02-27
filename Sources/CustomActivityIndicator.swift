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
            color = UIColor(named: colorName)
        }
    }
    
}
