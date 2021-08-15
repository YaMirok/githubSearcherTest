//
// Created by Damir Sitdikov on 14.07.2021.
//

import Foundation
import UIKit

final class HorizontalAnimationView: UIView {
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var lastScheduledOperation: DispatchWorkItem?

    private var isAnimating = false

    private let delta = 0.08

    lazy var startLocations: [NSNumber] = [
        NSNumber(floatLiteral: -delta),
        0.0,
        NSNumber(floatLiteral: delta)
    ]
    lazy var endLocations: [NSNumber] = [
        NSNumber(floatLiteral: 1 - delta),
        1.0,
        NSNumber(floatLiteral: 1 + delta)
    ]

    private(set) lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor.systemBlue.cgColor,
            UIColor.white.withAlphaComponent(0.5).cgColor,
            UIColor.systemBlue.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.locations = startLocations
        return gradient
    }()

    private func getNewAnimationInstance() -> CABasicAnimation {
        let gradientAnimation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.locations))
        gradientAnimation.fromValue = startLocations
        gradientAnimation.toValue = endLocations
        gradientAnimation.duration = 1
        gradientAnimation.repeatCount = Float.infinity
        return gradientAnimation
    }

    private var animationInstance: CABasicAnimation!

    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor.systemBlue
        gradient.frame = bounds
        layer.addSublayer(gradient)
        isHidden = true
    }

    override var bounds: CGRect {
        didSet {
            gradient.frame = bounds
        }
    }

    func startAnimation() {
        lastScheduledOperation?.cancel()
        let lastScheduledOperation = DispatchWorkItem { [unowned self] in
            guard !isAnimating else { return }
            isAnimating = true
            isHidden = false
            animationInstance = getNewAnimationInstance()
            gradient.add(animationInstance, forKey: nil)
        }
        self.lastScheduledOperation = lastScheduledOperation
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200), execute: lastScheduledOperation)
    }

    func stopAnimation() {
        lastScheduledOperation?.cancel()
        let lastScheduledOperation = DispatchWorkItem { [unowned self] in
            guard isAnimating else { return }
            isAnimating = false
            isHidden = true
        }
        self.lastScheduledOperation = lastScheduledOperation
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200), execute: lastScheduledOperation)
    }

    func restoreAnimationIfNeeded() {
        lastScheduledOperation?.cancel()
        DispatchQueue.main.async { [unowned self] in
            guard isAnimating else { return }
            gradient.removeAllAnimations()
            animationInstance = nil
            animationInstance = getNewAnimationInstance()
            gradient.add(animationInstance, forKey: nil)
        }
    }
}
