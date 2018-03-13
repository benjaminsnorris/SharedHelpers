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
        guard !text.isEmpty && characterIndex <= text.count else { return nil }
        if textStorage.attribute(NSAttributedStringKey.link, at: characterIndex, effectiveRange: nil) == nil {
            return nil
        }
        return self
    }
    
}
