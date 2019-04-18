/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

/// This variable holds references to the observer completion
/// blocks for each ViewController that registers.
fileprivate var observers = [String: [NSObjectProtocol]]()

/// A protocol that makes subscribing for and handling Keyboard changes/dismsissals
/// easier.
/// Default behavior is to provide a constraint that is attached
/// to the bottom of the screen, and that constraint will be
/// updated to have a constant of the keyboard height.
/// - Note: Indended to be adopted by UIViewControllers.
/// - Note: ViewControllers that conform to this endowment protocol will need
/// to call [registerForKeyboardNotifications()](x-source-tag://registerForKeyboardNotifications)
/// in order to enable the endowment behaviors it provides.
public protocol KeyboardAdjusting {
    /// This should be the constraint for the bottom of the view that should adjust with the keyboard
    /// - Tag: constraintToAdjust
    var constraintToAdjust: NSLayoutConstraint? { get }
    
    /// Overwrite this function if you want to pass in custom parameters
    /// to [keyboardWillChangeFrameHandler(notification:constraint:shouldAdjustOnDismissal:)](x-source-tag://keyboardWillChangeFrameHandler)
    func keyboardWillChangeFrame(_ notification: Notification)
    
    /// Overwrite this function if you want to pass in custom parameters
    /// to [keyboardWillDisappearHandler(constraint:)](x-source-tag://keyboardWillDisappearHandler)
    func keyboardWillDisappear()
}

public extension KeyboardAdjusting where Self: UIViewController {
    
    // MARK: Default Implementations
    
    func keyboardWillChangeFrame(_ notification: Notification) {
        keyboardWillChangeFrameHandler(notification)
    }
    
    func keyboardWillDisappear() {
        keyboardWillDisappearHandler()
    }
    
    
    // MARK: Default Methods
    
    /// A key used to keep track of the observers for each instance of ViewController
    /// that calls [registerForKeyboardNotifications()](x-source-tag://registerForKeyboardNotifications).
    fileprivate var observersKey: String { return String(describing: self) }
    
    /// Call this function in `viewDidLoad` in order to observe keyboard notifications.
    /// - Note: This function registers observers for `UIKeyboardWillChangeFrameNotification` and
    /// `UIKeyboardWillHideNotification`
    /// - Tag: registerForKeyboardNotifications
    func registerForKeyboardNotifications() {
        let keyboardChangeObserver = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: .main) { (notification) in
            self.keyboardWillChangeFrame(notification)
        }
        let keyboardHideObserver = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (notification) in
            self.keyboardWillDisappear()
        }
        
        unregisterForKeyboardNotifications() // In case this register method gets called multiple times, we don't want to execute the completion blocks multiple times per notification.
        var currentObservers = [NSObjectProtocol]()
        currentObservers.append(keyboardChangeObserver)
        currentObservers.append(keyboardHideObserver)
        observers[observersKey] = currentObservers
    }
    
    /// Unregisters from the `UIKeyboardWillChangeFrameNotification` and
    /// `UIKeyboardWillHideNotification` notifications.
    func unregisterForKeyboardNotifications() {
        let currentObservers = observers[observersKey] ?? [NSObjectProtocol]()
        currentObservers.forEach() { NotificationCenter.default.removeObserver($0) }
        observers[observersKey] = nil
    }
    
    /// Call this function from `keyboardWillChangeFrame` in order to have the contraint adjusted properly.
    /// The adjustment will be based on the height of the keyboard
    /// as contained in the notification payload.
    ///
    /// - Parameters:
    ///   - notification:  The `Notification` that is delivered containing
    /// information about the keyboard.
    ///   - providedConstraint: An optional constraint to adjust instead of the
    /// default [constraintToAdjust](x-source-tag://constraintToAdjust)
    ///   - shouldAdjustOnDismissal: 🤷‍♂️
    /// - Tag: keyboardWillChangeFrameHandler
    func keyboardWillChangeFrameHandler(_ notification: Notification, constraint providedConstraint: NSLayoutConstraint? = nil, shouldAdjustOnDismissal: Bool = true) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        guard let curveInt = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return }
        guard let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        guard let window = view.window else { return }
        guard let constraint = providedConstraint ?? constraintToAdjust else { return }
        
        var direction: CGFloat = 1.0
        if case .bottom = constraint.firstAttribute {
            direction = -1.0
        }
        let keyboardHeight = window.frame.height - keyboardFrame.origin.y
        var adjustedConstant = direction * keyboardHeight
        guard keyboardHeight != 0 && shouldAdjustOnDismissal else {
            return
        }
        
        if window.frame.height != keyboardFrame.origin.y {
            adjustedConstant = direction * (window.frame.height - keyboardFrame.origin.y - view.safeAreaInsets.bottom)
        }
        constraint.constant = adjustedConstant
        let curve = UIView.AnimationOptions(rawValue: curveInt)
        UIView.animate(withDuration: duration, delay: 0.0, options: [curve], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    ///Call this function from `keyboardWillHide` in order to have the constraint constant reset back to zero.
    ///
    /// - Parameter constraint: An optional constraint to adjust instead of the
    /// default [constraintToAdjust](x-source-tag://constraintToAdjust)
    /// - Tag: keyboardWillDisappearHandler
    func keyboardWillDisappearHandler(constraint: NSLayoutConstraint? = nil) {
        (constraint ?? constraintToAdjust)?.constant = view.safeAreaInsets.bottom
    }
    
}
