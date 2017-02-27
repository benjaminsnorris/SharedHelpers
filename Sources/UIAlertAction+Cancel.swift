/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

public extension UIAlertAction {
    
    public class var cancel: UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel button title"), style: .cancel, handler: nil)
    }
    
}
