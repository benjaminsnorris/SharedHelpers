/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

public class SmallCustomAlert: UIViewController, StoryboardInitializable {
    
    // MARK: - IB properties
    
    @IBOutlet weak var alertBackground: CustomView?
    @IBOutlet weak var image: CustomImageView?
    @IBOutlet weak var titleLabel: CustomLabel?
    @IBOutlet weak var messageLabel: CustomLabel?
    @IBOutlet weak var rightButton: CustomButton?
    
    
    // MARK: - Public properties
    
    public var styling = SmallAlertStyling() {
        didSet {
            updateUIStyling()
        }
    }
    public var config = Config() {
        didSet {
            updateUI()
        }
    }
    
    public struct Config {
        public var alertTitle: String?
        public var alertMessage: String?
        public var alertImage: UIImage?
        public var buttonImage: UIImage?
        public var buttonTitle: String = ""
        public var onRightButton: (() -> Void)?
        public var onDismiss: (() -> Void)?
        
        public init(alertTitle: String? = nil, alertMessage: String? = nil, alertImage: UIImage? = nil, buttonImage: UIImage? = nil, buttonTitle: String = "", onRightButton: (() -> Void)? = nil, onDismiss: (() -> Void)? = nil) {
            self.alertTitle = alertTitle
            self.alertMessage = alertMessage
            self.alertImage = alertImage
            self.buttonImage = buttonImage
            self.buttonTitle = buttonTitle
            self.onRightButton = onRightButton
            self.onDismiss = onDismiss
        }
    }
    
    
    // MARK: - Private properties
    
    fileprivate var timer: Timer?
    fileprivate var timerAmount: TimeInterval?

    
    // MARK: - Constants
    
    fileprivate static let topOffset: CGFloat = -200.0
    
    
    // MARK: - Lifecycle overrides
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        alertBackground?.layer.shadowOffset = .zero
        alertBackground?.layer.shadowOpacity = 0.4
        alertBackground?.layer.shadowRadius = 6.0
        
        rightButton?.layer.shadowOffset = .zero
        rightButton?.layer.shadowOpacity = 0.1
        rightButton?.layer.shadowRadius = 4.0
        
        alertBackground?.alpha = 0.0
        
        updateUI()
        updateUIStyling()
        
        if let passThrough = view as? PassThroughView {
            passThrough.presentingViewController = presentingViewController
        }
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        alertBackground?.alpha = 0.0
        alertBackground?.transform = CGAffineTransform(translationX: 0.0, y: SmallCustomAlert.topOffset)
        showAlert()
    }

    
    // MARK: - Public functions
    
    public func present(from viewController: UIViewController, for duration: TimeInterval? = nil, title: String? = nil, message: String? = nil, image: UIImage? = nil, buttonImage: UIImage? = nil, buttonTitle: String = NSLocalizedString("OK", comment: "Button title to dismiss alert"), onDismiss: (() -> Void)? = nil, onRightButton: (() -> Void)? = nil) {
        timer?.invalidate()
        let config = Config(alertTitle: title, alertMessage: message, alertImage: image, buttonImage: buttonImage, buttonTitle: buttonTitle, onRightButton: onRightButton, onDismiss: onDismiss)
        timerAmount = duration
        if let duration = duration {
            timer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(closeAlert), userInfo: nil, repeats: false)
        }
        if viewController.presentedViewController == self {
            reshowAlert(with: config)
        } else {
            self.config = config
            viewController.present(self, animated: false)
        }
    }
    
    public func dismissAlert() {
        closeAlert()
    }
    
    
    // MARK: - Internal functions
    
    func updateUI() {
        image?.image = config.alertImage
        image?.isHidden = config.alertImage == nil
        rightButton?.setTitle(config.buttonTitle, for: [])
        rightButton?.setImage(config.buttonImage, for: [])
        messageLabel?.text = config.alertMessage
        messageLabel?.isHidden = config.alertMessage == nil
        titleLabel?.text = config.alertTitle
        titleLabel?.isHidden = config.alertTitle == nil
    }
    
    func updateUIStyling() {
        alertBackground?.backgroundColorName = styling.backgroundColorName
        alertBackground?.shadowColorName = styling.shadowColorName
        rightButton?.backgroundColorName = styling.buttonColorName
        rightButton?.titleColorName = styling.buttonTextColorName
        rightButton?.tintColorName = styling.buttonTintColorName
        rightButton?.shadowColorName = styling.shadowColorName
        image?.tintColorName = styling.imageTintColorName
        messageLabel?.textColorName = styling.messageColorName
        titleLabel?.textColorName = styling.titleColorName
    }
    
    @IBAction func closeAlert() {
        timer?.invalidate()
        hideAlert {
            self.config.onDismiss?()
            self.dismiss(animated: false)
        }
    }
    
    @IBAction func rightButtonPressed() {
        if let onRightButton = config.onRightButton {
            onRightButton()
        } else {
            closeAlert()
        }
    }
    
    @IBAction func rightButtonTouchBegan() {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: {
            self.rightButton?.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        }, completion: nil)
    }
    
    @IBAction func rightButtonTouchEnded() {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: {
            self.rightButton?.transform = .identity
        }, completion: nil)
    }
    
    @IBAction func handlePan(_ recognizer: UIPanGestureRecognizer) {
        let maxDistance: CGFloat = 100.0
        switch recognizer.state {
        case .began:
            timer?.invalidate()
            alertBackground?.transform = .identity
            rightButtonTouchEnded()
        case .cancelled, .failed:
            alertBackground?.transform = .identity
        case .changed:
            let translation = recognizer.translation(in: view)
            var adjustedY = min(translation.y, maxDistance)
            if translation.y > maxDistance {
                let extra = translation.y - maxDistance
                let multiplierExtra = maxDistance - ((maxDistance / (maxDistance + extra)) * extra)
                let multiplier = multiplierExtra / maxDistance
                adjustedY += multiplier * extra
            }
            alertBackground?.transform = CGAffineTransform(translationX: 0.0, y: adjustedY)
        case .ended:
            let translation = recognizer.translation(in: view)
            let velocity = recognizer.velocity(in: view)
            let adjustedY = min(translation.y, maxDistance)
            if translation.y < 0 || velocity.y < -200 {
                self.closeAlert()
            } else {
                UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: (adjustedY / maxDistance) * (maxDistance * 0.4), options: [], animations: {
                    self.alertBackground?.transform = .identity
                }) { _ in
                    if let timerAmount = self.timerAmount {
                        self.timer = Timer.scheduledTimer(timeInterval: timerAmount, target: self, selector: #selector(self.closeAlert), userInfo: nil, repeats: false)
                    }
                }
            }
        case .possible:
            break
        }
    }
    
}


// MARK: - Private functions

private extension SmallCustomAlert {
    
    func reshowAlert(with config: Config) {
        hideAlert {
            self.config = config
            self.showAlert()
        }
    }
    
    func showAlert() {
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: [], animations: {
            self.alertBackground?.alpha = 1.0
            self.alertBackground?.transform = .identity
        }, completion: nil)
    }

    func hideAlert(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: {
            self.alertBackground?.transform = CGAffineTransform(translationX: 0.0, y: SmallCustomAlert.topOffset)
            self.alertBackground?.alpha = 0.0
        }) { _ in
            completion?()
        }
    }
    
}


public struct SmallAlertStyling {
    
    public let backgroundColorName: String?
    public let buttonColorName: String?
    public let buttonTextColorName: String?
    public let buttonTintColorName: String?
    public let imageTintColorName: String?
    public let messageColorName: String?
    public let shadowColorName: String?
    public let titleColorName: String?
    
    public init(backgroundColorName: String? = nil, buttonColorName: String? = nil, buttonTextColorName: String? = nil, buttonTintColorName: String? = nil, imageTintColorName: String? = nil, messageColorName: String? = nil, shadowColorName: String? = nil, titleColorName: String? = nil) {
        self.backgroundColorName = backgroundColorName
        self.buttonColorName = buttonColorName
        self.buttonTextColorName = buttonTextColorName
        self.buttonTintColorName = buttonTintColorName
        self.imageTintColorName = imageTintColorName
        self.messageColorName = messageColorName
        self.shadowColorName = shadowColorName
        self.titleColorName = titleColorName
    }
    
}


class PassThroughView: UIView {
    
    weak var presentingViewController: UIViewController?
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self ? presentingViewController?.view.hitTest(point, with: event) : view
    }
    
}
