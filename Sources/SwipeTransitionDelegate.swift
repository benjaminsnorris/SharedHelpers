/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

public class SwipeTransitionDelegate: NSObject {
    
    public var targetEdge: UIRectEdge
    public var edgeForDragging: UIRectEdge
    public var gestureRecognizer: UIPanGestureRecognizer?
    public var scrollView: UIScrollView?
    public var presentingCornerRadius: CGFloat
    public var dimmingBackgroundColor: UIColor?
    
    public init(targetEdge: UIRectEdge, edgeForDragging: UIRectEdge? = nil, gestureRecognizer: UIPanGestureRecognizer? = nil, scrollView: UIScrollView? = nil, presentingCornerRadius: CGFloat = 0.0, dimmingBackgroundColor: UIColor? = nil) {
        self.targetEdge = targetEdge
        if let edgeForDragging = edgeForDragging {
            self.edgeForDragging = edgeForDragging
        } else {
            self.edgeForDragging = targetEdge
        }
        self.gestureRecognizer = gestureRecognizer
        self.scrollView = scrollView
        self.presentingCornerRadius = presentingCornerRadius
        self.dimmingBackgroundColor = dimmingBackgroundColor
    }
    
}


// MARK: - View controller transitioning delegate

extension SwipeTransitionDelegate: UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SwipeTransitionAnimator(targetEdge: targetEdge, presentingCornerRadius: presentingCornerRadius, dimmingBackgroundColor: dimmingBackgroundColor)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SwipeTransitionAnimator(targetEdge: targetEdge, presentingCornerRadius: presentingCornerRadius, dimmingBackgroundColor: dimmingBackgroundColor)
    }
    
    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let gestureRecognizer = gestureRecognizer {
            return SwipeTransitionInteractionController(edgeForDragging: edgeForDragging, gestureRecognizer: gestureRecognizer, scrollView: scrollView)
        }
        return nil
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let gestureRecognizer = gestureRecognizer {
            return SwipeTransitionInteractionController(edgeForDragging: edgeForDragging, gestureRecognizer: gestureRecognizer, scrollView: scrollView)
        }
        return nil
    }
    
}
