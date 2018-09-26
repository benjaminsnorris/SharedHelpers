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
    
}
