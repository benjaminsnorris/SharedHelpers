/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

public extension UIView {
    
    public func constrainFullSize(_ view: UIView, leading: CGFloat = 0, top: CGFloat = 0, trailing: CGFloat = 0, bottom: CGFloat = 0) {
        guard let superview = view.superview else { fatalError("\(view) has no superview") }
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading).isActive = true
        view.topAnchor.constraint(equalTo: superview.topAnchor, constant: top).isActive = true
        view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -trailing).isActive = true
        view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -bottom).isActive = true
    }

}
