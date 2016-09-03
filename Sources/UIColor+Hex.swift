/*
 |  _   ____   ____   _
 | ⎛ |‾|  ⚈ |-| ⚈  |‾| ⎞
 | ⎝ |  ‾‾‾‾| |‾‾‾‾  | ⎠
 |  ‾        ‾        ‾
 */

import UIKit

public extension UIColor {
    
    public enum InputError: ErrorType {
        case UnableToScanHexValue
    }
    
    convenience public init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex >> 16) & 0xFF)/255.0
        let green = CGFloat((hex >> 8) & 0xFF)/255.0
        let blue = CGFloat((hex) & 0xFF)/255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience public init(hexString: String, alpha: CGFloat = 1.0) throws {
        var hexValue: UInt32 = 0
        guard NSScanner(string: hexString).scanHexInt(&hexValue) else {
            self.init() // Must init or we get EXEC_BAD_ACCESS
            throw InputError.UnableToScanHexValue
        }
        self.init(hex: Int(hexValue), alpha: alpha)
    }
    
    public var hexString: String {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        red = CGFloat(roundf(Float(red) * 255.0))
        green = CGFloat(roundf(Float(green) * 255.0))
        blue = CGFloat(roundf(Float(blue) * 255.0))
        alpha = CGFloat(roundf(Float(alpha) * 255.0))
        
        // Ignore alpha for now
        let hex: UInt = (UInt(red) << 16) | (UInt(green) << 8) | (UInt(blue))
        return String(format: "%06x", hex)
    }
    
}
