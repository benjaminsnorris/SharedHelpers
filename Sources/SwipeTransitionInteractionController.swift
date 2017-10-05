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
    fileprivate var initialContentOffset = CGPoint.zero
    
    static let velocityThreshold: CGFloat = 50.0
    
    init(edgeForDragging edge: UIRectEdge, gestureRecognizer: UIPanGestureRecognizer, scrollView: UIScrollView? = nil) {
        self.edge = edge
        self.gestureRecognizer = gestureRecognizer
        super.init()
        self.gestureRecognizer.addTarget(self, action: #selector(gestureRecognizerDidUpdate(_:)))
        self.scrollView = scrollView
        if let tableView = scrollView as? UITableView {
            initialContentOffset = tableView.style == .grouped ? CGPoint(x: 0, y: -44) : .zero
        }
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
                if scrollView.contentOffset.y >= initialContentOffset.y {
                    return 0
                }
            case .bottom:
                if scrollView.contentOffset.y <= initialContentOffset.y {
                    return 0
                }
            case .left:
                if scrollView.contentOffset.x >= initialContentOffset.x {
                    return 0
                }
            case .right:
                if scrollView.contentOffset.x <= initialContentOffset.x {
                    return 0
                }
            default:
                fatalError("edge must be .top, .bottom, .left, or .right. actual=\(edge)")
            }
            if adjustedInitialLocation == .zero {
                adjustedInitialLocation = recognizer.location(in: transitionContainerView)
            }
        }
        scrollView?.contentOffset = initialContentOffset
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
        case .possible, .began:
            break
        case .changed:
            update(percent(for: gestureRecognizer))
        case .ended:
            let velocity = gestureRecognizer.velocity(in: transitionContext?.containerView)
            var swiped = false
            switch edge {
            case .top:
                swiped = velocity.y > SwipeTransitionInteractionController.velocityThreshold
                if let scrollView = scrollView, scrollView.contentOffset.y > initialContentOffset.y {
                    swiped = false
                }
            case .bottom:
                swiped = velocity.y < -SwipeTransitionInteractionController.velocityThreshold
                if let scrollView = scrollView, scrollView.contentOffset.y < initialContentOffset.y {
                    swiped = false
                }
            case .left:
                swiped = velocity.x > SwipeTransitionInteractionController.velocityThreshold
                if let scrollView = scrollView, scrollView.contentOffset.x > initialContentOffset.x {
                    swiped = false
                }
            case .right:
                swiped = velocity.x < -SwipeTransitionInteractionController.velocityThreshold
                if let scrollView = scrollView, scrollView.contentOffset.x < initialContentOffset.x {
                    swiped = false
                }
            default:
                break
            }
            if swiped || percent(for: gestureRecognizer) >= 0.5 {
                finish()
            } else {
                cancel()
            }
        case .cancelled, .failed:
            cancel()
        }
    }
    
}
