/*
 |  _   ____   ____   _
 | ⎛ |‾|  ⚈ |-| ⚈  |‾| ⎞
 | ⎝ |  ‾‾‾‾| |‾‾‾‾  | ⎠
 |  ‾        ‾        ‾
 */

import UIKit

// MARK: - Button

@IBDesignable public class RoundedButton: UIButton {
    
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
}


// MARK: - ImageView

@IBDesignable public class RoundedImageView: UIImageView {
    
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable public var circular: Bool = false {
        didSet {
            layoutSubviews()
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        if circular {
            let minSideSize = min(frame.size.width, frame.size.height)
            layer.cornerRadius = minSideSize / 2.0
        }
    }

}


// MARK: - View

@IBDesignable public class RoundedView: UIView {
    
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable public var borderColor: UIColor? {
        get {
            guard let CGColor = layer.borderColor else { return nil }
            return UIColor(CGColor: CGColor)
        }
        set {
            layer.borderColor = newValue?.CGColor
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

}
