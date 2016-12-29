/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

public extension UIView {
    
    public func constrainFullSize(leading: CGFloat = 0, top: CGFloat = 0, trailing: CGFloat = 0, bottom: CGFloat = 0) {
        guard let superview = self.superview else { fatalError("\(self) has no superview") }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading).isActive = true
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: top).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -trailing).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -bottom).isActive = true
    }

}
