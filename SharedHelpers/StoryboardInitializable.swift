/*
 |  _   ____   ____   _
 | ⎛ |‾|  ⚈ |-| ⚈  |‾| ⎞
 | ⎝ |  ‾‾‾‾| |‾‾‾‾  | ⎠
 |  ‾        ‾        ‾
 */

import UIKit

protocol StoryboardInitializable {
    static var storyboardName: String { get }
    static var viewControllerIdentifier: String { get }
}

extension StoryboardInitializable where Self: UIViewController {
    
    static var storyboardName: String {
        return String(Self)
    }
    
    static var viewControllerIdentifier: String {
        return String(Self)
    }
    
    static func initializeFromStoryboard() -> Self {
        let bundle = NSBundle(forClass: Self.self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        guard let vc = storyboard.instantiateViewControllerWithIdentifier(viewControllerIdentifier) as? Self else { fatalError("Error instantiating \(self) from storyboard") }
        return vc
    }
    
}
