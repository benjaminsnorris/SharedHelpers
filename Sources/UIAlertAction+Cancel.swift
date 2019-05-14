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
    
    class var cancel: UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel button title"), style: .cancel) { _ in
            if #available(iOS 10.0, *) {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }
        }
    }
    
    func updateChecked(to isChecked: Bool) {
        setValue(isChecked, forKey: Keys.checked)
    }
    
    func updateImage(to image: UIImage) {
        setValue(image, forKey: Keys.image)
    }

}
