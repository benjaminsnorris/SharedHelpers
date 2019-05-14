/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

public extension UIButton {
    
    func setTitleWithoutFlashing(to title: String?, for state: UIControl.State = []) {
        UIView.performWithoutAnimation {
            setTitle(title, for: state)
            layoutIfNeeded()
        }
    }
    
    func setImageWithoutFlashing(to image: UIImage?, for state: UIControl.State = []) {
        UIView.performWithoutAnimation {
            setImage(image, for: state)
            layoutIfNeeded()
        }
    }
    
}
