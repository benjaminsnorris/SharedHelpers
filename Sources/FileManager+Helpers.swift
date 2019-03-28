/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import Foundation

public extension FileManager {
    
    static var documentsDirectory: URL {
        return try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
    
    static var temporaryDirectory: URL {
        return URL(fileURLWithPath: NSTemporaryDirectory())
    }
    
    static var cachesDirectory: URL {
        return try! FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
    
    static func copyDefaultItem(named name: String, to destination: URL, forceOverwrite: Bool = false) throws {
        guard let origin = Bundle.main.url(forResource: name, withExtension: nil) else { throw CocoaError(.fileNoSuchFile) }
        guard !FileManager.default.fileExists(atPath: destination.path) else {
            guard forceOverwrite else { return }
            try FileManager.default.removeItem(at: destination)
            try FileManager.default.copyItem(at: origin, to: destination)
            return
        }
        try FileManager.default.copyItem(at: origin, to: destination)
    }
    
    static func createDefaultDirectory(at destination: URL) throws {
        var isDirectory: ObjCBool = true
        guard !FileManager.default.fileExists(atPath: destination.path, isDirectory: &isDirectory) else { return }
        try FileManager.default.createDirectory(at: destination, withIntermediateDirectories: true, attributes: nil)
    }

}
