/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

public class SmallCustomAlert: UIViewController, StoryboardInitializable {
    
    // MARK: - IB properties
    
    @IBOutlet weak var alertView: CustomView?
    @IBOutlet weak var alertBackground: CustomView?
    @IBOutlet weak var image: CustomImageView?
    @IBOutlet weak var titleLabel: CustomLabel?
    @IBOutlet weak var messageLabel: CustomLabel?
    @IBOutlet weak var rightButton: CustomButton?
    @IBOutlet weak var handle: CustomView?
    
    
    // MARK: - Public properties
    
    public var styling = SmallAlertStyling() {
        didSet {
            updateUIStyling()
        }
    }
    
    struct Config {
        let alertTitle: String?
        let alertMessage: String?
        let alertImage: UIImage?
        let backgroundTintName: String?
        let buttonImage: UIImage?
        let buttonTitle: String?
        let onRightButton: (() -> Void)?
        let onDismiss: (() -> Void)?
        
        init(alertTitle: String? = nil, alertMessage: String? = nil, alertImage: UIImage? = nil, backgroundTintName: String? = nil, buttonImage: UIImage? = nil, buttonTitle: String? = nil, onRightButton: (() -> Void)? = nil, onDismiss: (() -> Void)? = nil) {
            self.alertTitle = alertTitle
            self.alertMessage = alertMessage
            self.alertImage = alertImage
            self.backgroundTintName = backgroundTintName
            self.buttonImage = buttonImage
            self.buttonTitle = buttonTitle
            self.onRightButton = onRightButton
            self.onDismiss = onDismiss
        }
    }
    
    
    // MARK: - Private properties
    
    fileprivate var config = Config() {
        didSet {
            updateUI()
        }
    }
    fileprivate var timer: Timer?
    fileprivate var timerAmount: TimeInterval?

    
    // MARK: - Constants
    
    fileprivate static let topOffset: CGFloat = -200.0
    fileprivate static let handleAlpha: CGFloat = 0.5
    fileprivate static let handleAlphaActive: CGFloat = 1.0

    
    // MARK: - Lifecycle overrides
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        alertView?.layer.shadowOffset = .zero
        alertView?.layer.shadowOpacity = 0.4
        alertView?.layer.shadowRadius = 6.0
        
        rightButton?.layer.shadowOffset = .zero
        rightButton?.layer.shadowOpacity = 0.1
        rightButton?.layer.shadowRadius = 4.0
        
        alertView?.alpha = 0.0
        handle?.alpha = SmallCustomAlert.handleAlpha
        
        updateUI()
        updateUIStyling()
        
        if let passThrough = view as? PassThroughView {
            passThrough.presentingViewController = presentingViewController
        }
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        alertView?.alpha = 0.0
        alertView?.transform = CGAffineTransform(translationX: 0.0, y: SmallCustomAlert.topOffset)
        showAlert()
    }

    
    // MARK: - Public functions
    
    public func present(from viewController: UIViewController, for duration: TimeInterval? = nil, title: String? = nil, message: String? = nil, backgroundTintName: String? = nil, image: UIImage? = nil, buttonImage: UIImage? = nil, buttonTitle: String? = NSLocalizedString("OK", comment: "Button title to dismiss alert"), onDismiss: (() -> Void)? = nil, onRightButton: (() -> Void)? = nil) {
        cancelTimer()
        let config = Config(alertTitle: title, alertMessage: message, alertImage: image, backgroundTintName: backgroundTintName, buttonImage: buttonImage, buttonTitle: buttonTitle, onRightButton: onRightButton, onDismiss: onDismiss)
        timerAmount = duration
        if let duration = duration {
            timer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(timerFired), userInfo: nil, repeats: false)
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
        alertBackground?.backgroundColorName = config.backgroundTintName
    }
    
    func updateUIStyling() {
        alertView?.backgroundColorName = styling.backgroundColorName
        alertView?.shadowColorName = styling.shadowColorName
        rightButton?.backgroundColorName = styling.buttonColorName
        rightButton?.titleColorName = styling.buttonTextColorName
        rightButton?.tintColorName = styling.buttonTintColorName
        rightButton?.shadowColorName = styling.shadowColorName
        handle?.backgroundColorName = styling.handleColorName
        image?.tintColorName = styling.imageTintColorName
        messageLabel?.textColorName = styling.messageColorName
        titleLabel?.textColorName = styling.titleColorName
    }
    
    func closeAlert() {
        cancelTimer()
        hideAlert {
            self.config.onDismiss?()
            self.dismiss(animated: false)
        }
    }
    
    func cancelTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func timerFired() {
        closeAlert()
    }
    
    @IBAction func rightButtonPressed() {
        if let onRightButton = config.onRightButton {
            onRightButton()
        } else {
            closeAlert()
        }
    }
    
    @IBAction func rightButtonTouchBegan() {
        cancelTimer()
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: {
            self.rightButton?.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        }, completion: nil)
    }
    
    @IBAction func rightButtonTouchEnded() {
        if let timerAmount = timerAmount {
            timer = Timer.scheduledTimer(timeInterval: timerAmount, target: self, selector: #selector(timerFired), userInfo: nil, repeats: false)
        }
        resetRightButton()
    }
    
    @IBAction func handlePan(_ recognizer: UIPanGestureRecognizer) {
        let maxDistance: CGFloat = 100.0
        let scale = CGAffineTransform(scaleX: 1.03, y: 1.03)
        switch recognizer.state {
        case .began:
            resetRightButton()
            cancelTimer()
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: {
                self.alertView?.transform = scale
                self.handle?.alpha = SmallCustomAlert.handleAlphaActive
            }, completion: nil)
        case .cancelled, .failed:
            alertView?.transform = .identity
            handle?.alpha = SmallCustomAlert.handleAlpha
        case .changed:
            let translation = recognizer.translation(in: view)
            var adjustedY = min(translation.y, maxDistance)
            if translation.y > maxDistance {
                let extra = translation.y - maxDistance
                let multiplierExtra = maxDistance - ((maxDistance / (maxDistance + extra)) * extra)
                let multiplier = multiplierExtra / maxDistance
                adjustedY += multiplier * extra
            }
            let translate = CGAffineTransform(translationX: 0.0, y: adjustedY)
            let combined = scale.concatenating(translate)
            alertView?.transform = combined
        case .ended:
            let translation = recognizer.translation(in: view)
            let velocity = recognizer.velocity(in: view)
            let adjustedY = min(translation.y, maxDistance)
            if translation.y < 0 || velocity.y < -200 {
                self.closeAlert()
                handle?.alpha = SmallCustomAlert.handleAlpha
            } else {
                UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: (adjustedY / maxDistance) * (maxDistance * 0.4), options: [], animations: {
                    self.alertView?.transform = .identity
                    self.handle?.alpha = SmallCustomAlert.handleAlpha
                }) { _ in
                    if let duration = self.timerAmount {
                        DispatchQueue.main.async {
                            self.timer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(self.timerFired), userInfo: nil, repeats: false)
                        }
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
            self.alertView?.alpha = 1.0
            self.alertView?.transform = .identity
        }, completion: nil)
    }

    func hideAlert(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: {
            self.alertView?.transform = CGAffineTransform(translationX: 0.0, y: SmallCustomAlert.topOffset)
            self.alertView?.alpha = 0.0
        }) { _ in
            completion?()
        }
    }
    
    func resetRightButton() {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: {
            self.rightButton?.transform = .identity
        }, completion: nil)
    }
    
}


public struct SmallAlertStyling {
    
    let backgroundColorName: String?
    let buttonColorName: String?
    let buttonTextColorName: String?
    let buttonTintColorName: String?
    let handleColorName: String?
    let imageTintColorName: String?
    let messageColorName: String?
    let shadowColorName: String?
    let titleColorName: String?
    
    public init(backgroundColorName: String? = nil, buttonColorName: String? = nil, buttonTextColorName: String? = nil, buttonTintColorName: String? = nil, handleColorName: String? = nil, imageTintColorName: String? = nil, messageColorName: String? = nil, shadowColorName: String? = nil, titleColorName: String? = nil) {
        self.backgroundColorName = backgroundColorName
        self.buttonColorName = buttonColorName
        self.buttonTextColorName = buttonTextColorName
        self.buttonTintColorName = buttonTintColorName
        self.handleColorName = handleColorName
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
