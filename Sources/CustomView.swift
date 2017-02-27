/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

@IBDesignable open class CustomView: UIView, CircularView, BackgroundColorNameable, TintColorNameable, BorderColorNameable {
    
    // MARK: - Inspectable properties
    
    @IBInspectable open var backgroundColorName: String? {
        didSet {
            applyBackgroundColorName()
        }
    }
    
    @IBInspectable open var tintColorName: String? {
        didSet {
            applyTintColorName()
        }
    }
    
    @IBInspectable open var borderColorName: String? {
        didSet {
            applyBorderColorName()
        }
    }
    
    @IBInspectable open var circular: Bool = false {
        didSet {
            layoutSubviews()
        }
    }
    
    
    // MARK: - Lifecycle overrides
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        applyCircularStyleIfNeeded()
    }
    
}
