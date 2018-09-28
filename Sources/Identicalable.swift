/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import Foundation

public protocol Identicalable {
    func isIdentical(to object: Self) -> Bool
}

extension String: Identicalable {
    
    public func isIdentical(to object: String) -> Bool {
        return self == object
    }
    
}

public extension Optional where Wrapped: Identicalable {
    
    func isIdentical(to optional: Wrapped?) -> Bool {
        if self == nil && optional == nil {
            return true
        }
        guard let object = self, let other = optional else { return false }
        return object.isIdentical(to: other)
    }
    
}

public extension Collection where Element: Identicalable {
    
    func isIdentical(to other: Self) -> Bool {
        guard count == other.count else { return false }
        let combined = zip(self, other)
        return combined.reduce(true) { result, pair in result && pair.0.isIdentical(to: pair.1) }
    }
    
}

public extension Dictionary where Value: Identicalable {
    
    func isIdentical(to other: Dictionary) -> Bool {
        guard count == other.count else { return false }
        var isIdentical = true
        for (key, value) in self {
            if !other[key].isIdentical(to: value) {
                isIdentical = false
                break
            }
        }
        return isIdentical
    }
    
}
