/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
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


// MARK: - UIView

public extension UIView {
    
    @IBInspectable open var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
}


// MARK: - Button

@IBDesignable open class RoundedButton: UIButton, CircularView {
    
    @IBInspectable open var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable open var borderColor: UIColor? {
        get {
            guard let CGColor = layer.borderColor else { return nil }
            return UIColor(cgColor: CGColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable open var circular: Bool = false {
        didSet {
            layoutSubviews()
        }
    }
    
    @IBInspectable open var loading: Bool = false {
        didSet {
            if loading {
                spinner.color = titleColor(for: UIControlState())
                spinner.startAnimating()
                savedTitle = titleLabel?.text
                setTitle(nil, for: UIControlState())
                accessibilityLabel = NSLocalizedString("Loading", comment: "Label for button while loading")
            } else {
                spinner.stopAnimating()
                setTitle(savedTitle, for: UIControlState())
                savedTitle = nil
                accessibilityLabel = nil
            }
        }
    }
    
    fileprivate let spinner = UIActivityIndicatorView(activityIndicatorStyle: .white)
    fileprivate var savedTitle: String?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        arrangeSpinner()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        arrangeSpinner()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        applyCircularStyleIfNeeded()
    }
    
    fileprivate func arrangeSpinner() {
        addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        spinner.stopAnimating()
    }
    
}


// MARK: - ImageView

@IBDesignable open class RoundedImageView: UIImageView, CircularView {
    
    @IBInspectable open var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable open var borderColor: UIColor? {
        get {
            guard let CGColor = layer.borderColor else { return nil }
            return UIColor(cgColor: CGColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable open var circular: Bool = false {
        didSet {
            layoutSubviews()
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        applyCircularStyleIfNeeded()
    }
    
}


// MARK: - View

@IBDesignable open class RoundedView: UIView, CircularView {
    
    @IBInspectable open var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable open var borderColor: UIColor? {
        get {
            guard let CGColor = layer.borderColor else { return nil }
            return UIColor(cgColor: CGColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable open var circular: Bool = false {
        didSet {
            layoutSubviews()
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        applyCircularStyleIfNeeded()
    }
    
}

