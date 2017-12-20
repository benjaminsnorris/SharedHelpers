/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

public extension UIViewController {
    
    public var topMostViewController: UIViewController {
        if presentedViewController == nil {
            return self
        }
        if let navigation = presentedViewController as? UINavigationController {
            if let visible = navigation.visibleViewController {
                return visible.topMostViewController
            }
            if let top = navigation.topViewController {
                return top.topMostViewController
            }
            return navigation.topMostViewController
        }
        if let tab = presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController
            }
            return tab.topMostViewController
        }
        return presentedViewController!.topMostViewController
    }
    
}

public extension UIApplication {
    
    public var topMostViewController: UIViewController? {
        return keyWindow?.rootViewController?.topMostViewController
    }
    
}
