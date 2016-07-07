/*
 |  _   ____   ____   _
 | ⎛ |‾|  ⚈ |-| ⚈  |‾| ⎞
 | ⎝ |  ‾‾‾‾| |‾‾‾‾  | ⎠
 |  ‾        ‾        ‾
 */

import UIKit

// MARK: - Label

@IBDesignable public class StyledLabel: UILabel {
    
    @IBInspectable public var textColorName: String? {
        didSet {
            guard let name = textColorName, color = UIColor.valueForKey(name) as? UIColor else { return }
            textColor = color
        }
    }
    
}


// MARK: - Text view

@IBDesignable public class StyledTextView: UITextView {
    
    @IBInspectable public var textColorName: String? {
        didSet {
            guard let name = textColorName, color = UIColor.valueForKey(name) as? UIColor else { return }
            textColor = color
        }
    }
    
}


// MARK: - Button

@IBDesignable public class StyledButton: UIButton, BackgroundColorNamed, TintColorNamed, BorderColorNamed, CircularView {
    
    @IBInspectable public var titleColorName: String? {
        didSet {
            guard let name = titleColorName, color = UIColor.valueForKey(name) as? UIColor else { return }
            setTitleColor(color, forState: .Normal)
        }
    }
    
    @IBInspectable public var backgroundColorName: String? {
        didSet {
            applyBackgroundColorName()
        }
    }
    
    @IBInspectable public var tintColorName: String? {
        didSet {
            applyTintColorName()
        }
    }
    
    @IBInspectable public var borderColorName: String? {
        didSet {
            applyBorderColorName()
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
        applyCircularStyleIfNeeded()
    }
    
}


// MARK: - ImageView

@IBDesignable public class StyledImageView: UIImageView, BackgroundColorNamed, TintColorNamed, BorderColorNamed, CircularView {
    
    @IBInspectable public var backgroundColorName: String? {
        didSet {
            applyBackgroundColorName()
        }
    }
    
    @IBInspectable public var tintColorName: String? {
        didSet {
            applyTintColorName()
        }
    }
    
    @IBInspectable public var borderColorName: String? {
        didSet {
            applyBorderColorName()
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
        applyCircularStyleIfNeeded()
    }
    
}


// MARK: - View

@IBDesignable public class StyledView: UIView, BackgroundColorNamed, TintColorNamed, BorderColorNamed, CircularView {
    
    @IBInspectable public var backgroundColorName: String? {
        didSet {
            applyBackgroundColorName()
        }
    }
    
    @IBInspectable public var tintColorName: String? {
        didSet {
            applyTintColorName()
        }
    }
    
    @IBInspectable public var borderColorName: String? {
        didSet {
            applyBorderColorName()
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
        applyCircularStyleIfNeeded()
    }
    
}


// MARK: - Table view cell

@IBDesignable public class StyledTableCell: UITableViewCell, BackgroundColorNamed {
    
    @IBInspectable public var backgroundColorName: String? {
        didSet {
            applyBackgroundColorName()
        }
    }
    
}


// MARK: - Table view

@IBDesignable public class StyledTableView: UITableView, BackgroundColorNamed {
    
    @IBInspectable public var backgroundColorName: String? {
        didSet {
            applyBackgroundColorName()
        }
    }
    
}


// MARK: - Switch

@IBDesignable public class StyledSwitch: UISwitch, TintColorNamed {
    
    @IBInspectable public var tintColorName: String? {
        didSet {
            onTintColor = UIColor(named: tintColorName)
        }
    }
    
}
