/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

open class RotatingViewController: UIViewController {
    
    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .all
    }
    
    @IBInspectable open var lightStatusBar: Bool = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    open override var preferredStatusBarStyle : UIStatusBarStyle {
        if lightStatusBar {
            return .lightContent
        }
        return .default
    }

}

open class RotatingNavController: UINavigationController {
    
    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .all
    }
    
    @IBInspectable open var lightStatusBar: Bool = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    open override var preferredStatusBarStyle : UIStatusBarStyle {
        if lightStatusBar {
            return .lightContent
        }
        return .default
    }
    
}
