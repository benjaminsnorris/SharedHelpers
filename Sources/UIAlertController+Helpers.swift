/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

public extension UIAlertController {
    
    public func addCancel(handler: ((UIAlertAction) -> Void)? = nil) {
        addCustomAction(with: NSLocalizedString("Cancel", comment: "Cancel button title"), handler: handler)
    }
    
    public func addOK(handler: ((UIAlertAction) -> Void)? = nil) {
        addCustomAction(with: NSLocalizedString("OK", comment: "OK button title"), handler: handler)
    }
    
    private func addCustomAction(with title: String, handler: ((UIAlertAction) -> Void)?) {
        let finalHandler = handler ?? { _ in
            if #available(iOS 10.0, *) {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }
        }
        addAction(UIAlertAction(title: title, style: .cancel, handler: finalHandler))
    }
    
}
