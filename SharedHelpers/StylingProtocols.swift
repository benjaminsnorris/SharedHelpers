/*
 |  _   ____   ____   _
 | ⎛ |‾|  ⚈ |-| ⚈  |‾| ⎞
 | ⎝ |  ‾‾‾‾| |‾‾‾‾  | ⎠
 |  ‾        ‾        ‾
 */

import UIKit

// MARK: - Color naming protocols

protocol BackgroundColorNamed {
    var backgroundColorName: String? { get set }
}

extension BackgroundColorNamed where Self: UIView {
    
    func applyBackgroundColorName() {
        backgroundColor = UIColor(named: backgroundColorName)
    }
    
}

protocol TintColorNamed {
    var tintColorName: String? { get set }
}

extension TintColorNamed where Self: UIView {
    
    func applyTintColorName() {
        tintColor = UIColor(named: tintColorName)
    }
    
}

protocol BorderColorNamed {
    var borderColorName: String? { get set }
}

extension BorderColorNamed where Self: UIView {
    
    func applyBorderColorName() {
        guard let color = UIColor(named: borderColorName) else { return }
        layer.borderColor = color.CGColor
    }
    
}


// MARK: - Circular view

protocol CircularView {
    var circular: Bool { get set }
}

extension CircularView where Self: UIView {
    
    func applyCircularStyleIfNeeded() {
        if circular {
            let minSideSize = min(frame.size.width, frame.size.height)
            layer.cornerRadius = minSideSize / 2.0
        }
    }
    
}
