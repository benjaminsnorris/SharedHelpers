/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import Foundation

public extension Collection {
    
    public func sort(ascending: Bool, _ isOrderedBefore: (Self.Iterator.Element, Self.Iterator.Element) -> Bool) -> [Self.Iterator.Element] {
        return sorted(by: { ascending == isOrderedBefore($0, $1) })
    }
    
}
