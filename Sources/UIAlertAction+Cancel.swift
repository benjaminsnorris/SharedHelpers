/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

public extension UIAlertAction {
    
    private enum Keys {
        static let checked = "checked"
        static let image = "image"
    }
    
    public class var cancel: UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel button title"), style: .cancel) { _ in
            if #available(iOS 10.0, *) {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }
        }
    }
    
    public func updateChecked(to isChecked: Bool) {
        setValue(isChecked, forKey: Keys.checked)
    }
    
    public func updateImage(to image: UIImage) {
        setValue(image, forKey: Keys.image)
    }

}
