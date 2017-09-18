/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

@IBDesignable open class CustomCollectionView: UICollectionView, BackgroundColorNameable {
    
    // MARK: - Inspectable properties
    
    @IBInspectable open var backgroundColorName: String? {
        didSet {
            applyBackgroundColorName()
        }
    }
    

    // MARK: - Initializers
    
    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        registerForNotifications()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        registerForNotifications()
    }
    
    
    // MARK: - Functions
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateColors), name: Notification.Name.AppearanceColorsUpdated, object: nil)
    }
    
    func updateColors() {
        applyBackgroundColorName()
    }
    
}

