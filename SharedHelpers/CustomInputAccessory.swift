/*
 |  _   ____   ____   _
 | ⎛ |‾|  ⚈ |-| ⚈  |‾| ⎞
 | ⎝ |  ‾‾‾‾| |‾‾‾‾  | ⎠
 |  ‾        ‾        ‾
 */

import UIKit

public protocol CustomInputAccessoryDelegate {
    func customButtonPressed()
    func donePressed()
}

public class CustomInputAccessory: UIView {
    
    // MARK: - Public properties
    
    public var customButtonTitle: String?
    

    // MARK: - Private properties
    
    private var delegate: CustomInputAccessoryDelegate?
    private var textInput: UIView?
    private let toolbar = UIToolbar()
    private let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: nil, action: #selector(CustomInputAccessory.doneTouched))
    
    
    // MARK: - Initializers
    
    convenience public init(textInput: UIView?) {
        self.init(frame: CGRectZero)
        self.textInput = textInput
        setupViews()
    }
    
    convenience public init(delegate: CustomInputAccessoryDelegate, customButtonTitle: String? = nil) {
        self.init(frame: CGRectZero)
        self.customButtonTitle = customButtonTitle
        self.delegate = delegate
        setupViews()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
}

    
// MARK: - Internal functions

extension CustomInputAccessory {
    
    func doneTouched() {
        if let delegate = delegate {
            delegate.donePressed()
        } else if let textInput = textInput {
            textInput.resignFirstResponder()
        }
    }
    
    func customButtonTouched() {
        delegate?.customButtonPressed()
    }
    
}


// MARK: - Private functions

private extension CustomInputAccessory {
    
    func setupViews() {
        let toolbarSize = toolbar.sizeThatFits(toolbar.frame.size)
        toolbar.frame = CGRectMake(0, 0, toolbarSize.width, toolbarSize.height)
        toolbar.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        frame = toolbar.frame
        
        let buttons: [UIBarButtonItem]
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        if let customButtonTitle = customButtonTitle {
            let customButton = UIBarButtonItem(title: customButtonTitle, style: .Plain, target: nil, action: #selector(CustomInputAccessory.customButtonTouched))
            buttons = [customButton, flexibleSpace, doneButton]
        } else {
            buttons = [flexibleSpace, doneButton]
        }
        toolbar.items = buttons
        addSubview(toolbar)
    }
    
}
