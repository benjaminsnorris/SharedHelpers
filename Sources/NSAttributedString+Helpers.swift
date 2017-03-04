/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import Foundation

public extension NSMutableAttributedString {
    
    public func increaseFontSize(by multiplier: CGFloat) {
        enumerateAttribute(NSFontAttributeName, in: NSMakeRange(0, length), options: []) { (font, range, stop) in
            guard let font = font as? UIFont else { return }
            let newFont = font.withSize(font.pointSize * multiplier)
            removeAttribute(NSFontAttributeName, range: range)
            addAttribute(NSFontAttributeName, value: newFont, range: range)
        }
    }
    
    func highlightStrings(_ stringToHighlight: String?, color: UIColor) {
        guard let stringToHighlight = stringToHighlight, !stringToHighlight.isEmpty else { return }
        do {
            let expression = try NSRegularExpression(pattern: stringToHighlight, options: [.caseInsensitive, .ignoreMetacharacters])
            let matches = expression.matches(in: string, options: [], range: NSRange(location: 0, length: length))
            for match in matches {
                self.addAttribute(NSBackgroundColorAttributeName, value: color, range: match.range)
            }
        } catch {
            print("status=could-not-create-regex error=\(error)")
        }
    }
    
}


public extension NSAttributedString {
    
    public func withIncreasedFontSize(by multiplier: CGFloat) -> NSAttributedString {
        let mutableCopy = NSMutableAttributedString(attributedString: self)
        mutableCopy.increaseFontSize(by: multiplier)
        return mutableCopy
    }
    
}
