/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

public extension UIFont {
    
    class func named(_ named: String?) -> UIFont? {
        guard let fullName = named else { return nil }
        var name = fullName
        var size = UIFont.systemFontSize
        if let range = fullName.range(of: "_") {
            name = String(fullName[..<range.lowerBound])
            let sizeString = String(fullName[range.upperBound...])
            if let sizeInt = Int(sizeString) {
                size = CGFloat(sizeInt)
            }
        }
        if let namedFont = UIFont.value(forKey: name) as? UIFont {
            return namedFont
        } else if let _font = UIFont(name: name, size: size) {
            return _font
        }
        return nil
    }
    
}
