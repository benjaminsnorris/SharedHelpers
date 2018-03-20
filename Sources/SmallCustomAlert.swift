/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

public class SmallCustomAlert: UIViewController, StoryboardInitializable {
    
    // MARK: - IB properties
    
    @IBOutlet weak var alertBackground: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    
    
    // MARK: - Constants
    
    fileprivate static let topOffset: CGFloat = -200.0
    
    
    // MARK: - Lifecycle overrides
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        alertBackground.layer.shadowOffset = .zero
        alertBackground.layer.shadowOpacity = 0.4
        alertBackground.layer.shadowRadius = 6.0
        
        image.isHidden = true
        
        rightButton.layer.shadowOffset = .zero
        rightButton.layer.shadowOpacity = 0.1
        rightButton.layer.shadowRadius = 4.0
        
        alertBackground.alpha = 0.0
        alertBackground.transform = CGAffineTransform(translationX: 0.0, y: SmallCustomAlert.topOffset)
        
        if let passThrough = view as? PassThroughView {
            passThrough.presentingViewController = presentingViewController
        }
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: [], animations: {
            self.alertBackground.alpha = 1.0
            self.alertBackground.transform = .identity
        }, completion: nil)
    }
    
    
    // MARK: - Internal functions
    
    @IBAction func closeAlert() {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: {
            self.alertBackground.transform = CGAffineTransform(translationX: 0.0, y: SmallCustomAlert.topOffset)
            self.alertBackground.alpha = 0.0
        }) { _ in
            self.dismiss(animated: false)
        }
    }
    
    @IBAction func rightButtonPressed() {
        closeAlert()
    }
    
    @IBAction func rightButtonTouchBegan() {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: {
            self.rightButton.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        }, completion: nil)
    }
    
    @IBAction func rightButtonTouchEnded() {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: {
            self.rightButton.transform = .identity
        }, completion: nil)
    }
    
    @IBAction func handlePan(_ recognizer: UIPanGestureRecognizer) {
        let maxDistance: CGFloat = 100.0
        switch recognizer.state {
        case .began:
            alertBackground.transform = .identity
            rightButtonTouchEnded()
        case .cancelled, .failed:
            alertBackground.transform = .identity
        case .changed:
            let translation = recognizer.translation(in: view)
            var adjustedY = min(translation.y, maxDistance)
            if translation.y > maxDistance {
                let extra = translation.y - maxDistance
                let multiplierExtra = maxDistance - ((maxDistance / (maxDistance + extra)) * extra)
                let multiplier = multiplierExtra / maxDistance
                adjustedY += multiplier * extra
            }
            alertBackground.transform = CGAffineTransform(translationX: 0.0, y: adjustedY)
        case .ended:
            let translation = recognizer.translation(in: view)
            let velocity = recognizer.velocity(in: view)
            let adjustedY = min(translation.y, maxDistance)
            if translation.y < 0 || velocity.y < -200 {
                self.closeAlert()
            } else {
                UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: (adjustedY / maxDistance) * (maxDistance * 0.4), options: [], animations: {
                    self.alertBackground.transform = .identity
                }, completion: nil)
            }
        case .possible:
            break
        }
    }
    
}


class PassThroughView: UIView {
    
    weak var presentingViewController: UIViewController?
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self ? presentingViewController?.view.hitTest(point, with: event) : view
    }
    
}
