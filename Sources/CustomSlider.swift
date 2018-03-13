/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

@IBDesignable open class CustomSlider: UISlider {
    
    // MARK: - Inspectable properties
    
    @IBInspectable open var steps: Int = 4 {
        didSet {
            updateSteps()
        }
    }
    
    @IBInspectable open var hasSteps: Bool = true {
        didSet {
            updateSteps()
        }
    }
    
    @IBInspectable open var stepColor: UIColor! = .lightGray {
        didSet {
            updateSteps()
        }
    }
    
    @IBInspectable open var stepColorName: String? {
        didSet {
            updateColors()
        }
    }
    
    
    // MARK: - Property overrides
    
    override open var value: Float {
        get {
            if hasSteps {
                return round(super.value * Float(steps)) / Float(steps)
            } else {
                return super.value
            }
        }
        set {
            super.value = newValue
        }
    }
    
    
    // MARK: - Private properties
    
    fileprivate let stackView = UIStackView()
    fileprivate let horizontalLine = UIView()
    
    
    // MARK: - Constants
    
    fileprivate static let sideMargin: CGFloat = 15.0
    
    
    // MARK: - Initializers
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    // MARK: - Functions
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateColors), name: Notification.Name.AppearanceColorsUpdated, object: nil)
    }
    
    @objc func updateColors() {
        stepColor = UIColor(withName: stepColorName)
    }

}


// MARK: - Private functions

private extension CustomSlider {

    func setupViews() {
        registerForNotifications()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(stackView, at: 0)
        stackView.constrainFullSize(leading: CustomSlider.sideMargin, trailing: CustomSlider.sideMargin)
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.isUserInteractionEnabled = false
        horizontalLine.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(horizontalLine, at: 0)
        horizontalLine.backgroundColor = stepColor
        horizontalLine.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        horizontalLine.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        horizontalLine.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
        horizontalLine.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        updateSteps()
        minimumTrackTintColor = .clear
        maximumTrackTintColor = .clear
    }
    
    func updateSteps() {
        for subview in stackView.subviews {
            subview.removeFromSuperview()
        }
        if hasSteps {
            for _ in 0...steps {
                stackView.addArrangedSubview(stepMarker())
            }
        }
        horizontalLine.backgroundColor = stepColor
    }
    
    func stepMarker() -> UIView {
        let marker = UIView()
        marker.backgroundColor = stepColor
        marker.heightAnchor.constraint(equalToConstant: 15.0).isActive = true
        marker.widthAnchor.constraint(equalToConstant: 1.0).isActive = true
        return marker
    }
    
}

