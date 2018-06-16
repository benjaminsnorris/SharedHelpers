/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

public extension UIAlertController {
    
    public func addCancel(handler: ((UIAlertAction) -> Void)? = nil) {
        addAction(customAction(with: NSLocalizedString("Cancel", comment: "Cancel button title"), handler: handler))
    }
    
    public func addOK(handler: ((UIAlertAction) -> Void)? = nil) {
        let action = customAction(with: NSLocalizedString("OK", comment: "OK button title"), handler: handler)
        addAction(action)
        preferredAction = action
    }
    
    private func customAction(with title: String, handler: ((UIAlertAction) -> Void)?) -> UIAlertAction {
        let finalHandler = handler ?? { _ in
            if #available(iOS 10.0, *) {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }
        }
        return UIAlertAction(title: title, style: .cancel, handler: finalHandler)
    }
    
}
