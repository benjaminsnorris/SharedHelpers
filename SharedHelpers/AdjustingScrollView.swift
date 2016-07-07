/*
 |  _   ____   ____   _
 | ⎛ |‾|  ⚈ |-| ⚈  |‾| ⎞
 | ⎝ |  ‾‾‾‾| |‾‾‾‾  | ⎠
 |  ‾        ‾        ‾
 */

import UIKit

@objc public protocol AdjustingScrollView {
    var scrollViewToAdjust: UIScrollView? { get }
    @objc func keyboardWillShow(notification: NSNotification)
    @objc func keyboardWillHide()
}

public extension AdjustingScrollView where Self: UIViewController {
    
    public func registerForKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
    }

    public func keyboardWillAppear(notification: NSNotification) {
        guard let userInfo = notification.userInfo, keyboardFrameValue = userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardFrameValue.CGRectValue()
        let keyboardSize = keyboardFrame.size
        
        let contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0)
        scrollViewToAdjust?.contentInset = contentInset
        scrollViewToAdjust?.scrollIndicatorInsets = contentInset
    }
    
    public func keyboardWillDisappear() {
        let contentInset = UIEdgeInsetsZero
        scrollViewToAdjust?.contentInset = contentInset
        scrollViewToAdjust?.scrollIndicatorInsets = contentInset
    }

}
