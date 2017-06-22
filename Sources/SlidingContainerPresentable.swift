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

fileprivate let topMargin: CGFloat = 64.0
fileprivate let cornerRadius: CGFloat = 12.0
fileprivate let velocityThreshold: CGFloat = 200.0

public protocol SlidingContainerPresentable: class {
    
    var modalContainer: UIView! { get }
    var blurEffectView: UIVisualEffectView? { get }
    var blurEffect: UIBlurEffect? { get }
    var progressWhenInterrupted: CGFloat { get set }
    
    @available(iOSApplicationExtension 10.0, *)
    var runningAnimators: [UIViewPropertyAnimator] { get set }
    
}

@available(iOSApplicationExtension 10.0, *)
public extension SlidingContainerPresentable where Self: UIViewController {
    
    public var blurEffectView: UIVisualEffectView? { return nil }
    public var blurEffect: UIBlurEffect? { return nil }
    
    public func animateTransitionIfNeeded(state: SlidingContainerPresentedState, duration: TimeInterval) {
        guard runningAnimators.isEmpty else { return }
        let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
            let viewFrame = self.view.frame
            switch state {
            case .expanded:
                self.modalContainer.frame = CGRect(x: 0, y: topMargin, width: viewFrame.width, height: viewFrame.height - topMargin)
            case .collapsed:
                self.modalContainer.frame = CGRect(x: 0, y: viewFrame.height, width: viewFrame.width, height: 0)
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
                self.modalContainer.layer.cornerRadius = cornerRadius
            case .collapsed:
                self.modalContainer.layer.cornerRadius = 0
            }
        }
        cornerAnimator.addCompletion { [weak self] _ in
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
    
    var currentContainerState: SlidingContainerPresentedState {
        return modalContainer.frame.height > 0 ? .expanded : .collapsed
    }
    
    var targetContainerState: SlidingContainerPresentedState {
        return modalContainer.frame.height > 0 ? .collapsed : .expanded
    }
    
    func percent(for recognizer: UIPanGestureRecognizer) -> CGFloat {
        guard let containerView = modalContainer else { return 0 }
        let locationInSourceView = recognizer.location(in: containerView)
        let delta = recognizer.translation(in: containerView)
        let originalLocation = CGPoint(x: locationInSourceView.x - delta.x, y: locationInSourceView.y - delta.y)
        let height = containerView.bounds.height
        
        let possibleHeight = height - originalLocation.y
        return delta.y / possibleHeight
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
            let swiped = velocity.y > velocityThreshold
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
