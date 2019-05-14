/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

public extension UISegmentedControl {
    
    func recommendedHeight(with padding: CGFloat) -> CGFloat? {
        var label: UILabel?
        guard let segment = subviews.first else { return nil }
        for subview in segment.subviews {
            if subview.isKind(of: UILabel.self) {
                label = subview as? UILabel
            }
        }
        guard let height = label?.frame.height else { return nil }
        return height + (padding * 2)
    }

    
}
