/*
 |  _   ____   ____   _
 | ⎛ |‾|  ⚈ |-| ⚈  |‾| ⎞
 | ⎝ |  ‾‾‾‾| |‾‾‾‾  | ⎠
 |  ‾        ‾        ‾
 */

import Foundation

extension CollectionType {
    
    func sort(ascending ascending: Bool, @noescape _ isOrderedBefore: (Self.Generator.Element, Self.Generator.Element) -> Bool) -> [Self.Generator.Element] {
        return sort({ ascending == isOrderedBefore($0, $1) })
    }
    
}
