/*
 |  _   ____   ____   _
 | ⎛ |‾|  ⚈ |-| ⚈  |‾| ⎞
 | ⎝ |  ‾‾‾‾| |‾‾‾‾  | ⎠
 |  ‾        ‾        ‾
 */

import UIKit

public class RotatingViewController: UIViewController {
    
    override public var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
}

public class RotatingNavController: UINavigationController {
    
    override public var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
}
