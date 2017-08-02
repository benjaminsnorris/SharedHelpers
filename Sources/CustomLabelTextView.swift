/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

@IBDesignable open class CustomLabelTextView: CustomTextView {
    
    override open func setupViews() {
        super.setupViews()
        isScrollEnabled = false
        isEditable = false
        textContainerInset = .zero
        textContainer.lineFragmentPadding = 0
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let characterIndex = layoutManager.characterIndex(for: point, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        if textStorage.attribute(NSLinkAttributeName, at: characterIndex, effectiveRange: nil) == nil {
            return nil
        }
        return self
    }
    
}
