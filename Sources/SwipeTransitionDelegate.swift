/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

public class SwipeTransitionDelegate: NSObject {
    
    public var targetEdge: UIRectEdge
    public var gestureRecognizer: UIPanGestureRecognizer?
    
    public init(targetEdge: UIRectEdge, gestureRecognizer: UIPanGestureRecognizer? = nil) {
        self.targetEdge = targetEdge
        self.gestureRecognizer = gestureRecognizer
    }
    
}


// MARK: - View controller transitioning delegate

extension SwipeTransitionDelegate: UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SwipeTransitionAnimator(targetEdge: targetEdge)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SwipeTransitionAnimator(targetEdge: targetEdge)
    }
    
    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let gestureRecognizer = gestureRecognizer {
            
        }
        return nil
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let gestureRecognizer = gestureRecognizer {
            
        }
        return nil
    }
    
}
