/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

@objc public protocol AdjustingScrollView {
    var scrollViewToAdjust: UIScrollView? { get }
    /// Function to implement in extension conforming to `AdjustingScrollView`
    @objc func keyboardWillShow(_ notification: Notification)
    /// Function to implement in extension conforming to `AdjustingScrollView`
    @objc func keyboardDidShow(_ notification: Notification)
    /// Function to implement in extension conforming to `AdjustingScrollView`
    @objc func keyboardWillHide()
}

public extension AdjustingScrollView where Self: UIViewController {
    
    /**
     Call this function in `viewDidLoad` in order to observe keyboard notifications.
     
     - Note: This function registers observers for `UIKeyboardDidShowNotification` and
        `UIKeyboardWillHideNotification`
     */
    public func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    /**
     Call this function from `keyboardWillShow` in order to have the scroll view adjust
     its content insets properly. The insets will be based on the height of the keyboard
     as contained in the notification payload.
     
     - parameter notification: The `NSNotification` that is delivered containing
     information about the keyboard.
     */
    public func keyboardWillAppear(_ notification: Notification, in viewController: UIViewController) {
        handleKeyboardNotification(notification, viewController: viewController)
    }

    /**
     Call this function from `keyboardDidShow` in order to have the scroll view adjust
     its content insets properly. The insets will be based on the height of the keyboard
     as contained in the notification payload.
     
     - parameter notification: The `NSNotification` that is delivered containing 
        information about the keyboard.
     */
    public func keyboardDidAppear(_ notification: Notification, in viewController: UIViewController) {
        handleKeyboardNotification(notification, viewController: viewController)
    }
    
    /**
     Call this function from `keyboardWillHide` in order to have the scroll view reset
     its content insets back to `UIEdgeInsetsZero`.
     */
    public func keyboardWillDisappear() {
        let contentInset = UIEdgeInsets.zero
        scrollViewToAdjust?.contentInset = contentInset
        scrollViewToAdjust?.scrollIndicatorInsets = contentInset
    }

}

private extension AdjustingScrollView {
    
    func handleKeyboardNotification(_ notification: Notification, viewController: UIViewController) {
        guard let userInfo = (notification as NSNotification).userInfo, let keyboardFrameValue = userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue, let scrollView = scrollViewToAdjust else { return }
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let convertedScrollViewFrame = scrollView.convert(scrollView.frame, to: viewController.view)
        let keyboardHeight = keyboardFrame.size.height
        let adjustedKeyboardFrame = CGRect(x: keyboardFrame.origin.x, y: keyboardFrame.origin.y - keyboardHeight, width: keyboardFrame.size.width, height: keyboardHeight)
        guard adjustedKeyboardFrame.intersects(convertedScrollViewFrame) else { return }
        let heightAdjustment = convertedScrollViewFrame.origin.y + convertedScrollViewFrame.size.height - adjustedKeyboardFrame.origin.y
        
        let contentInset = UIEdgeInsetsMake(0, 0, heightAdjustment, 0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
    
}
