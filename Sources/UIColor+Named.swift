/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

extension UIColor {
    
    public convenience init?(named: String?) {
        guard let name = named, let color = UIColor.value(forKey: name) as? UIColor else { return nil }
        self.init(cgColor: color.cgColor)
    }
    
}
