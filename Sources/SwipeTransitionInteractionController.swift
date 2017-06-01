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
    
    init(edgeForDragging edge: UIRectEdge, gestureRecognizer: UIPanGestureRecognizer) {
        self.edge = edge
        self.gestureRecognizer = gestureRecognizer
        super.init()
        self.gestureRecognizer.addTarget(self, action: #selector(gestureRecognizerDidUpdate(_:)))
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
        let locationInSourceView = recognizer.location(in: transitionContainerView)
        let delta = recognizer.translation(in: transitionContainerView)
        let originalLocation = CGPoint(x: locationInSourceView.x - delta.x, y: locationInSourceView.y - delta.y)
        let width = transitionContainerView.bounds.width
        let height = transitionContainerView.bounds.height
        
        if edge == .top {
            let possibleHeight = height - originalLocation.y
            return delta.y / possibleHeight
        } else if edge == .bottom {
            let possibleHeight = originalLocation.y
            return abs(delta.y) / possibleHeight
        } else if edge == .left {
            let possibleWidth = width - originalLocation.x
            return delta.x / possibleWidth
        } else if edge == .right {
            let possibleWidth = originalLocation.x
            return abs(delta.x) / possibleWidth
        } else {
            fatalError("edge must be .top, .bottom, .left, or .right. actual=\(edge)")
        }
    }
    
    func gestureRecognizerDidUpdate(_ gestureRecognizer: UIPanGestureRecognizer) {
        switch gestureRecognizer.state {
        case .began:
            break
        case .changed:
            update(percent(for: gestureRecognizer))
        case .ended:
            if percent(for: gestureRecognizer) >= 0.5 {
                finish()
            } else {
                cancel()
            }
        case .possible, .cancelled, .failed:
            cancel()
        }
    }
    
}
