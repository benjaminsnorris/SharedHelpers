/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

public extension String {
    
    func height(with width: CGFloat, font: UIFont = UIFont.preferredFont(forTextStyle: .body)) -> CGFloat {
        let nsString = self as NSString
        let rect = nsString.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return ceil(rect.height)
    }
    
}


public extension Optional where Wrapped == String {
    
    var isBlank: Bool {
        return (self ?? "").isEmpty
    }
    
}
