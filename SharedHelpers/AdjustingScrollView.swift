/*
 |  _   ____   ____   _
 | ⎛ |‾|  ⚈ |-| ⚈  |‾| ⎞
 | ⎝ |  ‾‾‾‾| |‾‾‾‾  | ⎠
 |  ‾        ‾        ‾
 */

import UIKit

@objc public protocol AdjustingScrollView {
    var scrollViewToAdjust: UIScrollView? { get }
    @objc func keyboardWillShow(_ notification: Notification)
    @objc func keyboardWillHide()
}

public extension AdjustingScrollView where Self: UIViewController {
    
    public func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    public func keyboardWillAppear(_ notification: Notification) {
        guard let userInfo = (notification as NSNotification).userInfo, let keyboardFrameValue = userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size
        
        let contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0)
        scrollViewToAdjust?.contentInset = contentInset
        scrollViewToAdjust?.scrollIndicatorInsets = contentInset
    }
    
    public func keyboardWillDisappear() {
        let contentInset = UIEdgeInsets.zero
        scrollViewToAdjust?.contentInset = contentInset
        scrollViewToAdjust?.scrollIndicatorInsets = contentInset
    }

}
