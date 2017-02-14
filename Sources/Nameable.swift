/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import Foundation

public protocol Nameable { }

public extension Nameable {
    
    public static var name: String {
        return String(describing: Self.self)
    }
    
}
