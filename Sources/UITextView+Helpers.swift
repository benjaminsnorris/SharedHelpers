/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

extension UITextView {
    
    public func treatAsLabel() {
        isScrollEnabled = false
        isEditable = false
        textContainerInset = .zero
        textContainer.lineFragmentPadding = 0
    }
    
}
