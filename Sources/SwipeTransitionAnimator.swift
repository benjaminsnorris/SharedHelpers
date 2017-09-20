/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

class SwipeTransitionAnimator: NSObject {
    
    var targetEdge: UIRectEdge
    
    fileprivate static let dimmingTag = -635
    
    init(targetEdge: UIRectEdge) {
        self.targetEdge = targetEdge
        super.init()
    }
    
}


// MARK: - View controller animated transitioning

extension SwipeTransitionAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
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
        if isPresenting {
            toView?.clipsToBounds = true
        }
        
        let offset: CGVector
        switch targetEdge {
        case .top:
            offset = CGVector(dx: 0, dy: -1)
            if #available(iOSApplicationExtension 11.0, *), isPresenting {
                toView?.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            }
        case .bottom:
            offset = CGVector(dx: 0, dy: 1)
            if #available(iOSApplicationExtension 11.0, *), isPresenting {
                toView?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            }
        case .left:
            offset = CGVector(dx: -1, dy: 0)
            if #available(iOSApplicationExtension 11.0, *), isPresenting {
                toView?.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            }
        case .right:
            offset = CGVector(dx: 1, dy: 0)
            if #available(iOSApplicationExtension 11.0, *), isPresenting {
                toView?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            }
        default:
            fatalError("targetEdge must be .top, .bottom, .left, or .right. actual=\(targetEdge)")
        }
        
        if isPresenting {
            toView?.frame = toFrame.offsetBy(dx: toFrame.width * offset.dx, dy: toFrame.height * offset.dy)
            fromView?.frame = fromFrame
        } else {
            toView?.frame = toFrame
        }
        
        let dimmingView = UIView()
        if let toView = toView, isPresenting {
            dimmingView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            dimmingView.alpha = 0
            dimmingView.frame = containerView.bounds
            dimmingView.tag = SwipeTransitionAnimator.dimmingTag
            containerView.addSubview(dimmingView)
            containerView.addSubview(toView)
        } else if let toView = toView, let fromView = fromView {
            containerView.insertSubview(toView, belowSubview: fromView)
        }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: {
            if isPresenting {
                toView?.frame = toFrame
                toView?.layer.cornerRadius = 10.0
                dimmingView.alpha = 1.0
            } else {
                fromView?.layer.cornerRadius = 0.0
                fromView?.frame = fromFrame.offsetBy(dx: fromFrame.width * offset.dx, dy: fromFrame.height * offset.dy)
                if let dimming = containerView.subviews.first(where: { $0.tag == SwipeTransitionAnimator.dimmingTag }) {
                    dimming.alpha = 0.0
                }
            }
        }) { _ in
            let wasCancelled = transitionContext.transitionWasCancelled
            if wasCancelled {
                toView?.removeFromSuperview()
            } else if !isPresenting {
                if let dimming = containerView.subviews.first(where: { $0.tag == SwipeTransitionAnimator.dimmingTag }) {
                    dimming.removeFromSuperview()
                }
            }
            transitionContext.completeTransition(!wasCancelled)
        }
    }
    
}
