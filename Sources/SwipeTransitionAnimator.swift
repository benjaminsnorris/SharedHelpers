/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

class SwipeTransitionAnimator: NSObject {
    
    var targetEdge: UIRectEdge
    
    init(targetEdge: UIRectEdge) {
        self.targetEdge = targetEdge
        super.init()
    }
    
}


// MARK: - View controller animated transitioning

extension SwipeTransitionAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to)
            else { return }
        let containerView = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)
        let toView = transitionContext.view(forKey: .to)

        let isPresenting = toViewController.presentingViewController == fromViewController
        let fromFrame = transitionContext.initialFrame(for: fromViewController)
        let toFrame = transitionContext.finalFrame(for: toViewController)
        
        let offset: CGVector
        if targetEdge == .top {
            offset = CGVector(dx: 0, dy: 1)
        } else if targetEdge == .bottom {
            offset = CGVector(dx: 0, dy: -1)
        } else if targetEdge == .left {
            offset = CGVector(dx: 1, dy: 0)
        } else if targetEdge == .right {
            offset = CGVector(dx: -1, dy: 0)
        } else {
            fatalError("targetEdge must be .top, .bottom, .left, or .right. actual=\(targetEdge)")
        }
        
        fromView?.frame = fromFrame
        if isPresenting {
            toView?.frame = toFrame.offsetBy(dx: toFrame.width * offset.dx * -1, dy: toFrame.height * offset.dy * -1)
        } else {
            toView?.frame = toFrame
        }
        
        if let toView = toView, isPresenting {
            containerView.addSubview(toView)
        } else if let toView = toView, let fromView = fromView {
            containerView.insertSubview(toView, belowSubview: fromView)
        }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: {
            if isPresenting {
                toView?.frame = toFrame
            } else {
                fromView?.frame = fromFrame.offsetBy(dx: fromFrame.width * offset.dx, dy: fromFrame.height * offset.dy)
            }
        }) { _ in
            let wasCancelled = transitionContext.transitionWasCancelled
            if wasCancelled {
                toView?.removeFromSuperview()
            }
            transitionContext.completeTransition(!wasCancelled)
        }
    }
    
}
