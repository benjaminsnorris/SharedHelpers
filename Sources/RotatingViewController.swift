/*
 |  _   ____   ____   _
 | ⎛ |‾|  ⚈ |-| ⚈  |‾| ⎞
 | ⎝ |  ‾‾‾‾| |‾‾‾‾  | ⎠
 |  ‾        ‾        ‾
 */

import UIKit

public class RotatingViewController: UIViewController {
    
    override public func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .All
    }
    
    @IBInspectable public var lightStatusBar: Bool = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    public override func preferredStatusBarStyle() -> UIStatusBarStyle {
        if lightStatusBar {
            return .LightContent
        }
        return .Default
    }

}

public class RotatingNavController: UINavigationController {
    
    override public func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .All
    }
    
    @IBInspectable public var lightStatusBar: Bool = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    public override func preferredStatusBarStyle() -> UIStatusBarStyle {
        if lightStatusBar {
            return .LightContent
        }
        return .Default
    }
    
}
