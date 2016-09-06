/*
 |  _   ____   ____   _
 | ⎛ |‾|  ⚈ |-| ⚈  |‾| ⎞
 | ⎝ |  ‾‾‾‾| |‾‾‾‾  | ⎠
 |  ‾        ‾        ‾
 */

import UIKit

// MARK: - Circular view

protocol CircularView {
    var circular: Bool { get set }
}

extension CircularView where Self: UIView {
    
    func applyCircularStyleIfNeeded() {
        if circular {
            let minSideSize = min(frame.size.width, frame.size.height)
            layer.cornerRadius = minSideSize / 2.0
        }
    }
    
}


// MARK: - Button

@IBDesignable public class RoundedButton: UIButton, CircularView {
    
    @IBInspectable public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
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
    
    @IBInspectable public var loading: Bool = false {
        didSet {
            if loading {
                spinner.color = titleColorForState(.Normal)
                spinner.startAnimating()
                savedTitle = titleLabel?.text
                setTitle(nil, forState: .Normal)
                accessibilityLabel = NSLocalizedString("Loading", comment: "Label for button while loading")
            } else {
                spinner.stopAnimating()
                setTitle(savedTitle, forState: .Normal)
                savedTitle = nil
                accessibilityLabel = nil
            }
        }
    }
    
    private let spinner = UIActivityIndicatorView(activityIndicatorStyle: .White)
    private var savedTitle: String?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        arrangeSpinner()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        arrangeSpinner()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        applyCircularStyleIfNeeded()
    }
    
    private func arrangeSpinner() {
        addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraintEqualToAnchor(centerXAnchor).active = true
        spinner.centerYAnchor.constraintEqualToAnchor(centerYAnchor).active = true
        spinner.stopAnimating()
    }
    
}


// MARK: - ImageView

@IBDesignable public class RoundedImageView: UIImageView, CircularView {
    
    @IBInspectable public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
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

@IBDesignable public class RoundedView: UIView, CircularView {
    
    @IBInspectable public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
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
