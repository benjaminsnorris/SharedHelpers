/*
 |  _   ____   ____   _
 | ⎛ |‾|  ⚈ |-| ⚈  |‾| ⎞
 | ⎝ |  ‾‾‾‾| |‾‾‾‾  | ⎠
 |  ‾        ‾        ‾
 */

import UIKit

public class RotatingViewController: UIViewController {
    
    override public func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .all
    }
    
}

public class RotatingNavController: UINavigationController {
    
    override public func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .all
    }
    
}
