/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

public protocol Nameable { }

public extension Nameable {
    
    public static var name: String {
        return String(describing: Self.self)
    }
    
    public func addAccessibilityIdentifiers() {
        for (label, object) in Mirror(reflecting: self).children {
            guard let label = label else { continue }
            let accessibleObject: UIAccessibilityIdentification
            if let view = object as? UIView {
                accessibleObject = view
            } else if let barItem = object as? UIBarItem {
                accessibleObject = barItem
            } else {
                continue
            }
            accessibleObject.accessibilityIdentifier = Self.name + "." + label
        }
    }

}
