/*
 |  _   ____   ____   _
 | ⎛ |‾|  ⚈ |-| ⚈  |‾| ⎞
 | ⎝ |  ‾‾‾‾| |‾‾‾‾  | ⎠
 |  ‾        ‾        ‾
 */

import Foundation

struct SemanticVersion {
    var major: Int
    var minor: Int
    var patch: Int
    
    init?(_ versionString: String) {
        let components = versionString.componentsSeparatedByString(".")
        guard let majorString = components.first, major = Int(majorString) else { return nil }
        self.major = major
        minor = 0
        patch = 0
        guard components.count > 1, let minor = Int(components[1]) else { return }
        self.minor = minor
        guard components.count > 2, let patch = Int(components[2]) else { return }
        self.patch = patch
    }
    
}

extension SemanticVersion: CustomStringConvertible {
    
    var description: String {
        return "\(major).\(minor).\(patch)"
    }
    
}

extension SemanticVersion: Comparable {}

func == (lhs: SemanticVersion, rhs: SemanticVersion) -> Bool {
    return lhs.major == rhs.major && lhs.minor == rhs.minor && lhs.patch == rhs.patch
}

func < (lhs: SemanticVersion, rhs: SemanticVersion) -> Bool {
    if lhs.major < rhs.major && lhs.minor <= rhs.minor && lhs.patch <= rhs.patch {
        return true
    }
    if lhs.major == rhs.major && lhs.minor < rhs.minor && lhs.patch <= rhs.patch {
        return true
    }
    if lhs.major == rhs.major && lhs.minor == rhs.minor && lhs.patch < rhs.patch {
        return true
    }
    return false
}
