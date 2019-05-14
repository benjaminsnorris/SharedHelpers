/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

public extension UIFont {
    
    convenience init?(named: String?) {
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
        var font: UIFont
        if let namedFont = UIFont.value(forKey: name) as? UIFont {
            font = namedFont
        } else if let _font = UIFont(name: name, size: size) {
            font = _font
        } else {
            return nil
        }
        self.init(name: font.fontName, size: font.pointSize)
    }
    
}
