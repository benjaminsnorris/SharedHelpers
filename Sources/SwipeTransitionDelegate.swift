/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

public class SwipeTransitionDelegate: NSObject {
    
    public var targetEdge: UIRectEdge
    public var edgeForDragging: UIRectEdge?
    public var gestureRecognizer: UIPanGestureRecognizer?
    
    public init(targetEdge: UIRectEdge, edgeForDragging: UIRectEdge? = nil, gestureRecognizer: UIPanGestureRecognizer? = nil) {
        self.targetEdge = targetEdge
        if let edgeForDragging = edgeForDragging {
            self.edgeForDragging = edgeForDragging
        } else {
            self.edgeForDragging = targetEdge
        }
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
            return SwipeTransitionInteractionController(edgeForDragging: targetEdge, gestureRecognizer: gestureRecognizer)
        }
        return nil
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let gestureRecognizer = gestureRecognizer {
            return SwipeTransitionInteractionController(edgeForDragging: targetEdge, gestureRecognizer: gestureRecognizer)
        }
        return nil
    }
    
}
