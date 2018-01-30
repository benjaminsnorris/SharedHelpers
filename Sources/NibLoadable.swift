/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

public protocol NibLoadable {
    static var nibName: String { get }
}

public extension NibLoadable where Self: UIView {
    
    public static var nibName: String {
        return String(describing: Self.self)
    }
    
    public static var nib: UINib {
        let bundle = Bundle(for: Self.self)
        return UINib(nibName: Self.nibName, bundle: bundle)
    }
    
    /**
     Function to load custom view from corresponding nib file.
     
     - returns: `UIView` that is defined in the nib file
     */
    public func loadFromNib() -> UIView {
        guard let view = Self.nib.instantiate(withOwner: self, options: nil).first as? UIView else { fatalError("Error loading \(self) from nib") }
        return view
    }
    
    /**
     Loads the custom view from the nib, and adds it as a subview to the `UIView` custom
     subclass, constraining it to the full size of the view. 
     */
    public func initializeFromNib() {
        let view = loadFromNib()
        addSubview(view)
        view.constrainFullSize()
    }
    
}
