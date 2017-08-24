/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

@objc public protocol KeyboardAdjusting {
    /// This should be the constraint for the bottom of the view that should adjust with the keyboard
    var constraintToAdjust: NSLayoutConstraint? { get }
    @objc func keyboardWillChangeFrame(_ notification: Notification)
    @objc func keyboardWillHide()
}

public extension KeyboardAdjusting where Self: UIViewController {
    
    /**
     Call this function in `viewDidLoad` in order to observe keyboard notifications.
     
     - Note: This function registers observers for `UIKeyboardWillChangeFrameNotification` and
     `UIKeyboardWillHideNotification`
     */
    public func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    /**
     Call this function from `keyboardWillChangeFrame` in order to have the contraint adjusted properly.
     The adjustment will be based on the height of the keyboard
     as contained in the notification payload.
     
     - Note: The constraint to adjust is assumed to be at the bottom of the view
     controller's view. If it is not at the bottom, unexpected results may occur.
     
     - Parameters:
       - notification: The `Notification` that is delivered containing
    information about the keyboard.
       - constraint: _(Optional)_ An explicit constraint to adjust
       - statusBarHeight: The height of the shared application status bar
     (`UIApplication.shared.statusBarFrame.height`). Used for form sheet modals.
     */
    public func keyboardWillChange(_ notification: Notification, constraint: NSLayoutConstraint? = nil, statusBarHeight: CGFloat = 0.0) {
        guard let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect,
            let curveInt = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double
            else { return }
        let adjustedConstant = self.adjustedConstant(for: keyboardFrame, statusBarHeight: statusBarHeight)
        let curve = UIViewAnimationOptions(rawValue: curveInt)
        UIView.animate(withDuration: duration, delay: 0.0, options: [curve], animations: {
            if let constraint = constraint {
                constraint.constant = adjustedConstant
            } else {
                self.constraintToAdjust?.constant = adjustedConstant
            }
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    /**
     Call this function in something like `viewDidAppear` when the keyboard is already
     showing.
     
     - Note: In order for this to work, you must be tracking the frame of the keyboard
     outside of this view controller.
    
     - Parameters:
       - keyboardFrame: Saved frame of the keyboard that is currently visible
       - constraint: _(Optional)_ An explicit constraint to adjust
       - statusBarHeight: The height of the shared application status bar
       (`UIApplication.shared.statusBarFrame.height`). Used for form sheet modals.
     */
    public func adjustConstraint(for keyboardFrame: CGRect, constraint: NSLayoutConstraint? = nil, statusBarHeight: CGFloat = 0.0) {
        let adjustedConstant = self.adjustedConstant(for: keyboardFrame, statusBarHeight: statusBarHeight)
        let constraint = constraint ?? constraintToAdjust
        constraint?.constant = adjustedConstant
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func adjustedConstant(for keyboardFrame: CGRect, statusBarHeight: CGFloat = 0.0) -> CGFloat {
        guard let window = view.window,
            let wrapper = view.superview
            else { return 0.0 }
        let adjustedFrame = wrapper.convert(wrapper.frame, to: window)
        var maxY = adjustedFrame.maxY
        if modalPresentationStyle == .formSheet || navigationController?.modalPresentationStyle == .formSheet {
            maxY = wrapper.frame.height + statusBarHeight
        }
        let offset = maxY - keyboardFrame.origin.y
        return max(offset, 0)
    }
    
    /**
     Call this function from `keyboardWillHide` in order to have the constraint constant reset back to zero.
     */
    public func keyboardWillDisappear(constraint: NSLayoutConstraint? = nil) {
        if let constraint = constraint {
            constraint.constant = 0
        } else {
            constraintToAdjust?.constant = 0
        }
    }

}
