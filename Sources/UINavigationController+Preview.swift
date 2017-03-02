/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

extension UINavigationController {
    
    open override var previewActionItems : [UIPreviewActionItem] {
        if let items = topViewController?.previewActionItems {
            return items
        } else {
            return super.previewActionItems
        }
    }
    
}
