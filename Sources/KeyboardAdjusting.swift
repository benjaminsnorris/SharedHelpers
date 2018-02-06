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
    /// This should be the scroll view that needs to be adjusted for the keyboard
    var scrollViewToAdjust: UIScrollView? { get }
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
        guard keyboardFrame.height > 0 else { setConstant(of: constraint, to: 0, animated: true); return }
        let adjustedConstant = self.adjustedConstant(for: keyboardFrame, statusBarHeight: statusBarHeight)
        let curve = UIViewAnimationOptions(rawValue: curveInt)
        setConstant(of: constraint, to: adjustedConstant, animated: true, duration: duration, curve: curve)
        let adjustedInset = self.adjustedInset(for: keyboardFrame, statusBarHeight: statusBarHeight)
        adjustBottomInsets(to: adjustedInset, animated: true, duration: duration, curve: curve)
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
        guard keyboardFrame.height > 0 else { setConstant(of: constraint, to: 0); return }
        let adjustedConstant = self.adjustedConstant(for: keyboardFrame, statusBarHeight: statusBarHeight)
        setConstant(of: constraint, to: adjustedConstant)
    }
    
    func adjustedConstant(for keyboardFrame: CGRect, using wrapperView: UIView? = nil, statusBarHeight: CGFloat = 0.0) -> CGFloat {
        let adjustedWrapper = wrapperView ?? view.superview
        guard let window = view.window,
            let wrapper = adjustedWrapper,
            let wrapperParent = wrapper.superview
            else { return 0.0 }
        let adjustedFrame = wrapperParent.convert(wrapper.frame, to: nil)
        var maxY = adjustedFrame.maxY
        if modalPresentationStyle == .formSheet || navigationController?.modalPresentationStyle == .formSheet {
            maxY = wrapper.frame.height + statusBarHeight
        }
        maxY = min(maxY, window.frame.maxY)
        let offset = maxY - keyboardFrame.origin.y
        return max(offset, 0)
    }
    
    func adjustedInset(for keyboardFrame: CGRect, statusBarHeight: CGFloat = 0.0) -> CGFloat {
        return adjustedConstant(for: keyboardFrame, using: scrollViewToAdjust, statusBarHeight: statusBarHeight)
    }
    
    /**
     Call this function from `keyboardWillHide` in order to have the constraint constant reset back to zero.
     */
    public func keyboardWillDisappear(constraint: NSLayoutConstraint? = nil) {
        setConstant(of: constraint, to: 0, animated: true)
        adjustBottomInsets(to: 0, animated: true)
    }
    
    func setConstant(of constraint: NSLayoutConstraint?, to constant: CGFloat, animated: Bool = false, duration: TimeInterval = 0.3, curve: UIViewAnimationOptions? = nil) {
        if animated {
            UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [curve ?? .curveEaseInOut], animations: {
                self.finishSettingConstant(of: constraint, to: constant)
            }, completion: nil)
        } else {
            finishSettingConstant(of: constraint, to: constant)
        }
    }
    
    func finishSettingConstant(of constraint: NSLayoutConstraint?, to constant: CGFloat) {
        if let constraint = constraint {
            constraint.constant = constant
        } else {
            constraintToAdjust?.constant = constant
        }
        view.layoutIfNeeded()
    }
    
    func adjustBottomInsets(to constant: CGFloat, animated: Bool = false, duration: TimeInterval = 0.3, curve: UIViewAnimationOptions? = nil) {
        if animated {
            UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [curve ?? .curveEaseInOut], animations: {
                self.finishAdjustingBottomInsets(to: constant)
            }, completion: nil)
        } else {
            finishAdjustingBottomInsets(to: constant)
        }
    }
    
    func finishAdjustingBottomInsets(to constant: CGFloat) {
        if let scrollView = scrollViewToAdjust {
            scrollView.contentInset.bottom = constant
            scrollView.scrollIndicatorInsets.bottom = constant
        }
    }

}
