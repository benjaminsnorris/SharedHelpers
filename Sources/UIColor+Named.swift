/*
 |  _   ____   ____   _
 | ⎛ |‾|  ⚈ |-| ⚈  |‾| ⎞
 | ⎝ |  ‾‾‾‾| |‾‾‾‾  | ⎠
 |  ‾        ‾        ‾
 */

import UIKit

extension UIColor {
    
    convenience init?(named: String?) {
        guard let name = named, color = UIColor.valueForKey(name) as? UIColor else { return nil }
        self.init(CGColor: color.CGColor)
    }
    
}
