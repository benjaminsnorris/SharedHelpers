/*
 |  _   ____   ____   _
 | ⎛ |‾|  ⚈ |-| ⚈  |‾| ⎞
 | ⎝ |  ‾‾‾‾| |‾‾‾‾  | ⎠
 |  ‾        ‾        ‾
 */

import UIKit

@objc public protocol AdjustingScrollView {
    var scrollViewToAdjust: UIScrollView? { get }
    /// Function to implement in extension conforming to `AdjustingScrollView`
    @objc func keyboardWillShow(notification: NSNotification)
    /// Function to implement in extension conforming to `AdjustingScrollView`
    @objc func keyboardDidShow(notification: NSNotification)
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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
    }

    /**
     Call this function from `keyboardWillShow` in order to have the scroll view adjust
     its content insets properly. The insets will be based on the height of the keyboard
     as contained in the notification payload.
     
     - parameter notification: The `NSNotification` that is delivered containing
     information about the keyboard.
     */
    public func keyboardWillAppear(notification: NSNotification) {
        handleKeyboardNotification(notification)
    }

    /**
     Call this function from `keyboardDidShow` in order to have the scroll view adjust
     its content insets properly. The insets will be based on the height of the keyboard
     as contained in the notification payload.
     
     - parameter notification: The `NSNotification` that is delivered containing 
        information about the keyboard.
     */
    public func keyboardDidAppear(notification: NSNotification) {
        handleKeyboardNotification(notification)
    }
    
    /**
     Call this function from `keyboardWillHide` in order to have the scroll view reset
     its content insets back to `UIEdgeInsetsZero`.
     */
    public func keyboardWillDisappear() {
        let contentInset = UIEdgeInsetsZero
        scrollViewToAdjust?.contentInset = contentInset
        scrollViewToAdjust?.scrollIndicatorInsets = contentInset
    }

}

private extension AdjustingScrollView {
    
    private func handleKeyboardNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo, keyboardFrameValue = userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue, scrollView = scrollViewToAdjust else { return }
        let keyboardFrame = keyboardFrameValue.CGRectValue()
        let convertedScrollViewFrame = scrollView.convertRect(scrollView.frame, toCoordinateSpace: UIScreen.mainScreen().coordinateSpace)
        let keyboardHeight = keyboardFrame.size.height
        let adjustedKeyboardFrame = CGRectMake(keyboardFrame.origin.x, keyboardFrame.origin.y - keyboardHeight, keyboardFrame.size.width, keyboardHeight)
        guard adjustedKeyboardFrame.intersects(convertedScrollViewFrame) else { return }
        let heightAdjustment = convertedScrollViewFrame.origin.y + convertedScrollViewFrame.size.height - adjustedKeyboardFrame.origin.y
        
        let contentInset = UIEdgeInsetsMake(0, 0, heightAdjustment, 0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
    
}
