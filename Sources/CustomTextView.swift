/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

@IBDesignable open class CustomTextView: UITextView, TintColorNameable, BackgroundColorNameable, BorderColorNameable, FontNameable {
    
    // MARK: - Inspectable properties
    
    @IBInspectable open var fontName: String? {
        didSet {
            applyFontName()
        }
    }
    
    @IBInspectable open var textColorName: String? {
        didSet {
            updateTextColor()
        }
    }
    
    @IBInspectable open var tintColorName: String? {
        didSet {
            applyTintColorName()
        }
    }
    
    @IBInspectable open var backgroundColorName: String? {
        didSet {
            applyBackgroundColorName()
        }
    }
    
    @IBInspectable open var borderColorName: String? {
        didSet {
            applyBorderColorName()
        }
    }
    
    @IBInspectable open var passThruTouches: Bool = false
    
    
    // MARK: - Computed properties
    
    open var displayFont: UIFont? {
        get {
            return font
        }
        set {
            font = newValue
        }
    }
    
    
    // MARK: - Initializers
    
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    
    // MARK: - Lifecycle overrides
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        applyFontName()
    }

    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard passThruTouches else { return self }
        let characterIndex = layoutManager.characterIndex(for: point, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        guard !text.isEmpty && characterIndex <= text.count else { return nil }
        if textStorage.attribute(NSAttributedStringKey.link, at: characterIndex, effectiveRange: nil) == nil {
            return nil
        }
        return self
    }

    
    // MARK: - Functions
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateColors), name: Notification.Name.AppearanceColorsUpdated, object: nil)
    }
    
    @objc func updateColors() {
        applyBackgroundColorName()
        applyTintColorName()
        applyBorderColorName()
        updateTextColor()
    }
    
    func updateTextColor() {
        textColor = UIColor(withName: textColorName)
    }
    
    open func setupViews() {
        registerForNotifications()
    }

}
