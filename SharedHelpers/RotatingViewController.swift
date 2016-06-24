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
    
}

public class RotatingNavController: UINavigationController {
    
    override public func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .All
    }
    
}
