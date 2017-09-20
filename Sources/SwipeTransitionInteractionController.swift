/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

class SwipeTransitionInteractionController: UIPercentDrivenInteractiveTransition {
    
    var edge: UIRectEdge
    var gestureRecognizer: UIPanGestureRecognizer
    weak var transitionContext: UIViewControllerContextTransitioning?
    var scrollView: UIScrollView?
    
    fileprivate var adjustedInitialLocation = CGPoint.zero
    
    static let velocityThreshold: CGFloat = 200.0
    
    init(edgeForDragging edge: UIRectEdge, gestureRecognizer: UIPanGestureRecognizer, scrollView: UIScrollView? = nil) {
        self.edge = edge
        self.gestureRecognizer = gestureRecognizer
        super.init()
        self.gestureRecognizer.addTarget(self, action: #selector(gestureRecognizerDidUpdate(_:)))
        self.scrollView = scrollView
    }
    
    @available(*, unavailable, message: "Use `init(edgeForDragging:gestureRecognizer:) instead")
    override init() {
        fatalError("Use `init(edgeForDragging:gestureRecognizer:) instead")
    }
    
    deinit {
        gestureRecognizer.removeTarget(self, action: #selector(gestureRecognizerDidUpdate(_:)))
    }
    
    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        super.startInteractiveTransition(transitionContext)
    }
    
    func percent(for recognizer: UIPanGestureRecognizer) -> CGFloat {
        guard let transitionContainerView = transitionContext?.containerView else { return 0 }
        if let scrollView = scrollView, percentComplete == 0 {
            switch edge {
            case .top:
                if scrollView.contentOffset.y >= 0 {
                    return 0
                }
            case .bottom:
                if scrollView.contentOffset.y <= 0 {
                    return 0
                }
            case .left:
                if scrollView.contentOffset.x >= 0 {
                    return 0
                }
            case .right:
                if scrollView.contentOffset.x <= 0 {
                    return 0
                }
            default:
                fatalError("edge must be .top, .bottom, .left, or .right. actual=\(edge)")
            }
            if adjustedInitialLocation == .zero {
                adjustedInitialLocation = recognizer.location(in: transitionContainerView)
            }
        }
        scrollView?.contentOffset = .zero
        let delta = recognizer.translation(in: transitionContainerView)
        let width = transitionContainerView.bounds.width
        let height = transitionContainerView.bounds.height
        var adjustedPoint = delta
        if adjustedInitialLocation != .zero {
            let locationInSourceView = recognizer.location(in: transitionContainerView)
            adjustedPoint = CGPoint(x: locationInSourceView.x - adjustedInitialLocation.x, y: locationInSourceView.y - adjustedInitialLocation.y)
        }
        
        switch edge {
        case .top:
            return adjustedPoint.y > 0 ? adjustedPoint.y / height : 0
        case .bottom:
            return adjustedPoint.y < 0 ? abs(adjustedPoint.y) / height : 0
        case .left:
            return adjustedPoint.x > 0 ? adjustedPoint.x / height : 0
        case .right:
            return adjustedPoint.x < 0 ? abs(adjustedPoint.x) / width : 0
        default:
            fatalError("edge must be .top, .bottom, .left, or .right. actual=\(edge)")
        }
    }
    
    func gestureRecognizerDidUpdate(_ gestureRecognizer: UIPanGestureRecognizer) {
        switch gestureRecognizer.state {
        case .began:
            adjustedInitialLocation = .zero
        case .changed:
            update(percent(for: gestureRecognizer))
        case .ended:
            let velocity = gestureRecognizer.velocity(in: transitionContext?.containerView)
            var swiped = false
            if edge == .top {
                swiped = velocity.y > SwipeTransitionInteractionController.velocityThreshold
            } else if edge == .bottom {
                swiped = velocity.y < -SwipeTransitionInteractionController.velocityThreshold
            } else if edge == .left {
                swiped = velocity.x > SwipeTransitionInteractionController.velocityThreshold
            } else if edge == .right {
                swiped = velocity.x < -SwipeTransitionInteractionController.velocityThreshold
            }
            if swiped || percent(for: gestureRecognizer) >= 0.5 {
                finish()
            } else {
                cancel()
            }
        case .possible, .cancelled, .failed:
            cancel()
        }
    }
    
}
