/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

public extension UIImage {
    
    func trimmedToSquare(ofSize square: CGFloat, mirror: Bool = false) -> UIImage {
        
        // Trim rectangle to largest centered square.
        let oldSize = size
        let squareInImage = min(oldSize.width, oldSize.height)
        
        // Draw offset in new rect so that square starts at (0, 0).
        let minSquare = min(square, squareInImage)
        let scaling = minSquare / squareInImage
        let newSize = CGSize(width: minSquare, height: minSquare)
        var newRect = CGRect(origin: CGPoint.zero, size: newSize)
        let remainder = abs(oldSize.height - oldSize.width) * scaling
        if oldSize.width >= oldSize.height {
            newRect.origin.x -= remainder / 2
            newRect.size.width += remainder
        } else {
            newRect.origin.y -= remainder / 2
            newRect.size.height += remainder
        }
        
        UIGraphicsBeginImageContextWithOptions(newSize, true, 1.0)
        defer { UIGraphicsEndImageContext() }
        
        if let context = UIGraphicsGetCurrentContext(), let imageRef = self.cgImage {
            
            // Rescale using highest quality.
            context.interpolationQuality = .high
            let flipVertical = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: newSize.height)
            context.concatenate(flipVertical)
            
            if mirror {
                let flipHorizontal = CGAffineTransform(a: -1, b: 0, c: 0, d: 1, tx: newSize.width, ty: 0)
                context.concatenate(flipHorizontal)
            }
            
            // Draw into the context; this scales the image.
            context.draw(imageRef, in: newRect)
            
            // Get the resized image.
            if let scaledImage = UIGraphicsGetImageFromCurrentImageContext() {
                return scaledImage
            }
        }
        
        return self
    }
    
}
