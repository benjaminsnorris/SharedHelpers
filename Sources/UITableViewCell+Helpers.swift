/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

public extension UITableViewCell {
    
    /// Hides cell separator by setting the left edge insets
    /// to match the cell width
    func hideSeparator() {
        separatorInset = UIEdgeInsets(top: 0, left: bounds.width, bottom: 0, right: 0)
    }
    
}
