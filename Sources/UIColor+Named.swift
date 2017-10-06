/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

extension UIColor {
    
    public convenience init?(withName name: String?) {
        guard let name = name, let color = UIColor.value(forKey: name) as? UIColor else { return nil }
        self.init(cgColor: color.cgColor)
    }
    
}
