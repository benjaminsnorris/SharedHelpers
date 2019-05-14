/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import Foundation

public extension Array {
    
    var random: Element? {
        let index = Int(arc4random_uniform(UInt32(count)))
        guard index < count else { return nil }
        return self[index]
    }
    
}
