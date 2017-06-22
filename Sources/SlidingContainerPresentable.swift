/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

public enum SlidingContainerPresentedState {
    case collapsed
    case expanded
}

fileprivate let velocityThreshold: CGFloat = 200.0

public protocol SlidingContainerPresentable: class {
    
    var modalContainer: UIView! { get }
    var blurEffectView: UIVisualEffectView? { get }
    var blurEffect: UIBlurEffect? { get }
    
    var anchorEdge: UIRectEdge { get }
    var minMargin: CGFloat { get }
    var maxSize: CGFloat? { get }
    var cornerRadius: CGFloat { get }
    
    var progressWhenInterrupted: CGFloat { get set }
    
    @available(iOSApplicationExtension 10.0, *)
    var runningAnimators: [UIViewPropertyAnimator] { get set }
    
}

@available(iOSApplicationExtension 10.0, *)
public extension SlidingContainerPresentable where Self: UIViewController {
    
    public var blurEffectView: UIVisualEffectView? { return nil }
    public var blurEffect: UIBlurEffect? { return nil }
    public var minMargin: CGFloat { return 64.0 }
    public var maxSize: CGFloat? { return nil }
    public var cornerRadius: CGFloat { return 12.0 }
    
    var relevantSize: CGFloat {
        if anchorEdge == .left || anchorEdge == .right {
            return modalContainer.frame.width
        }
        return modalContainer.frame.height
    }
    
    var targetContainerState: SlidingContainerPresentedState {
        return relevantSize > 0 ? .collapsed : .expanded
    }
    

    public func animateTransitionIfNeeded(state: SlidingContainerPresentedState, duration: TimeInterval) {
        guard runningAnimators.isEmpty else { return }
        let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
            let viewFrame = self.view.frame
            switch state {
            case .expanded:
                let maximumSize = self.maxSize ?? 0
                if self.anchorEdge == .top {
                    self.modalContainer.frame = CGRect(x: 0, y: 0, width: viewFrame.width, height: max(viewFrame.height - self.minMargin, maximumSize))
                } else if self.anchorEdge == .bottom {
                    self.modalContainer.frame = CGRect(x: 0, y: self.maxSize == nil ? self.minMargin : viewFrame.height - maximumSize, width: viewFrame.width, height: max(viewFrame.height - self.minMargin, maximumSize))
                } else if self.anchorEdge == .left {
                    self.modalContainer.frame = CGRect(x: 0, y: 0, width: self.maxSize ?? viewFrame.width - self.minMargin, height: viewFrame.height)
                } else if self.anchorEdge == .right {
                    self.modalContainer.frame = CGRect(x: self.maxSize == nil ? self.minMargin : viewFrame.width - maximumSize, y: 0, width: self.maxSize ?? viewFrame.width - self.minMargin, height: viewFrame.height)
                } else {
                    fatalError("status=invalid-anchor-edge actual=\(self.anchorEdge)")
                }
            case .collapsed:
                if self.anchorEdge == .top {
                    self.modalContainer.frame = CGRect(x: 0, y: 0, width: viewFrame.width, height: 0)
                } else if self.anchorEdge == .bottom {
                    self.modalContainer.frame = CGRect(x: 0, y: viewFrame.height, width: viewFrame.width, height: 0)
                } else if self.anchorEdge == .left {
                    self.modalContainer.frame = CGRect(x: 0, y: 0, width: 0, height: viewFrame.height)
                } else if self.anchorEdge == .right {
                    self.modalContainer.frame = CGRect(x: viewFrame.width, y: 0, width: 0, height: viewFrame.height)
                } else {
                    fatalError("status=invalid-anchor-edge actual=\(self.anchorEdge)")
                }
            } }
        frameAnimator.addCompletion { [weak self] _ in
            guard let `self` = self, let index = self.runningAnimators.index(of: frameAnimator) else { return }
            self.runningAnimators.remove(at: index)
        }
        frameAnimator.startAnimation()
        runningAnimators.append(frameAnimator)
        
        if let blurEffectView = blurEffectView {
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    blurEffectView.effect = self.blurEffect ?? UIBlurEffect(style: .dark)
                case .collapsed:
                    blurEffectView.effect = nil
                }
            }
            blurAnimator.addCompletion { [weak self] position in
                guard let `self` = self, let index = self.runningAnimators.index(of: blurAnimator) else { return }
                self.runningAnimators.remove(at: index)
                let isShowing: Bool
                switch state {
                case .expanded:
                    isShowing = position == .end
                case .collapsed:
                    isShowing = position == .start
                }
                blurEffectView.isUserInteractionEnabled = isShowing
                blurEffectView.effect = isShowing ? self.blurEffect ?? UIBlurEffect(style: .dark) : nil
                self.modalContainer.layer.cornerRadius = isShowing ? self.cornerRadius : 0
            }
            blurAnimator.startAnimation()
            runningAnimators.append(blurAnimator)
        }
        
        let cornerAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) { 
            switch state {
            case .expanded:
//                if #available(iOSApplicationExtension 11.0, *) {
//                    self.modalContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//                }
                self.modalContainer.layer.cornerRadius = self.cornerRadius
            case .collapsed:
                self.modalContainer.layer.cornerRadius = 0
            }
        }
        cornerAnimator.addCompletion { [weak self] position in
            guard let `self` = self, let index = self.runningAnimators.index(of: cornerAnimator) else { return }
            self.runningAnimators.remove(at: index)
        }
        cornerAnimator.startAnimation()
        runningAnimators.append(cornerAnimator)
    }
    
    public func animateOrReverseRunningTransition(state: SlidingContainerPresentedState? = nil, duration: TimeInterval) {
        let targetState = state ?? targetContainerState
        if runningAnimators.isEmpty {
            animateTransitionIfNeeded(state: targetState, duration: duration)
        } else {
            for animator in runningAnimators {
                animator.isReversed = !animator.isReversed
            }
        }
    }
    
    func percent(for recognizer: UIPanGestureRecognizer) -> CGFloat {
        let locationInSourceView = recognizer.location(in: view)
        let delta = recognizer.translation(in: view)
        let originalLocation = CGPoint(x: locationInSourceView.x - delta.x, y: locationInSourceView.y - delta.y)
        let width = view.bounds.width
        let height = view.bounds.height
        
        if anchorEdge == .top {
            let possibleHeight = originalLocation.y
            return abs(delta.y) / possibleHeight
        } else if anchorEdge == .bottom {
            let possibleHeight = height - originalLocation.y
            return delta.y / possibleHeight
        } else if anchorEdge == .left {
            let possibleWidth = originalLocation.x
            return abs(delta.x) / possibleWidth
        } else if anchorEdge == .right {
            let possibleWidth = width - originalLocation.x
            return delta.x / possibleWidth
        } else {
            fatalError("edge must be .top, .bottom, .left, or .right. actual=\(anchorEdge)")
        }
    }
    
    public func handlePan(with recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            animateTransitionIfNeeded(state: targetContainerState, duration: 1.0)
            runningAnimators.forEach { $0.pauseAnimation() }
            let fractionsComplete = runningAnimators.map { $0.fractionComplete }
            progressWhenInterrupted = fractionsComplete.max() ?? 0
        case .changed:
            runningAnimators.forEach { animator in
                animator.fractionComplete = percent(for: recognizer) + progressWhenInterrupted
            }
        case .ended:
            let timing = UICubicTimingParameters(animationCurve: .easeOut)
            let velocity = recognizer.velocity(in: view)
            var swiped = false
            if anchorEdge == .top {
                swiped = velocity.y < -velocityThreshold
            } else if anchorEdge == .bottom {
                swiped = velocity.y > velocityThreshold
            } else if anchorEdge == .left {
                swiped = velocity.x < -velocityThreshold
            } else if anchorEdge == .right {
                swiped = velocity.x > velocityThreshold
            }
            let shouldReverse = !swiped && percent(for: recognizer) < 0.5
            runningAnimators.forEach { animator in
                animator.isReversed = shouldReverse
                animator.continueAnimation(withTimingParameters: timing, durationFactor: 0)
            }
        case .possible, .failed, .cancelled:
            break
        }
    }
    
}
