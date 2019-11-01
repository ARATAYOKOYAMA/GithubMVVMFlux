//
//  TestESTabBarContentView.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/11/02.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import Foundation
import UIKit
import pop
import ESTabBarController_swift

class ExampleBasicContentView: ESTabBarItemContentView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = UIColor(white: 175.0 / 255.0, alpha: 1.0)
        highlightTextColor = UIColor(red: 254 / 255.0, green: 73 / 255.0, blue: 42 / 255.0, alpha: 1.0)
        iconColor = UIColor(white: 175.0 / 255.0, alpha: 1.0)
        highlightIconColor = UIColor(red: 254 / 255.0, green: 73 / 255.0, blue: 42 / 255.0, alpha: 1.0)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class ExampleBouncesContentView: ExampleBasicContentView {

    public var duration = 0.3

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func selectAnimation(animated: Bool, completion: (() -> Void)?) {
        self.bounceAnimation()
        completion?()
    }

    override func reselectAnimation(animated: Bool, completion: (() -> Void)?) {
        self.bounceAnimation()
        completion?()
    }

    func bounceAnimation() {
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        impliesAnimation.values = [1.0, 1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        impliesAnimation.duration = duration * 2
        impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
        imageView.layer.add(impliesAnimation, forKey: nil)
    }
}

class ExampleIrregularityBasicContentView: ExampleBouncesContentView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        textColor = UIColor(white: 255.0 / 255.0, alpha: 1.0)
        highlightTextColor = UIColor(red: 23 / 255.0, green: 149 / 255.0, blue: 158 / 255.0, alpha: 1.0)
        iconColor = UIColor(white: 255.0 / 255.0, alpha: 1.0)
        highlightIconColor = UIColor(red: 23 / 255.0, green: 149 / 255.0, blue: 158 / 255.0, alpha: 1.0)
        backdropColor = UIColor(red: 10 / 255.0, green: 66 / 255.0, blue: 91 / 255.0, alpha: 1.0)
        highlightBackdropColor = UIColor(red: 10 / 255.0, green: 66 / 255.0, blue: 91 / 255.0, alpha: 1.0)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ExampleIrregularityContentView: ESTabBarItemContentView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.imageView.backgroundColor = UIColor(red: 23 / 255.0, green: 149 / 255.0, blue: 158 / 255.0, alpha: 1.0)
        self.imageView.layer.borderWidth = 3.0
        self.imageView.layer.borderColor = UIColor(white: 235 / 255.0, alpha: 1.0).cgColor
        self.imageView.layer.cornerRadius = 35
        self.insets = UIEdgeInsets(top: -32, left: 0, bottom: 0, right: 0)
        let transform = CGAffineTransform.identity
        self.imageView.transform = transform
        self.superview?.bringSubviewToFront(self)

        textColor = UIColor(white: 255.0 / 255.0, alpha: 1.0)
        highlightTextColor = UIColor(white: 255.0 / 255.0, alpha: 1.0)
        iconColor = UIColor(white: 255.0 / 255.0, alpha: 1.0)
        highlightIconColor = UIColor(white: 255.0 / 255.0, alpha: 1.0)
        backdropColor = .clear
        highlightBackdropColor = .clear
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let point = CGPoint(x: point.x - imageView.frame.origin.x, y: point.y - imageView.frame.origin.y)
        return sqrt(pow(imageView.bounds.size.width / 2.0 - point.x, 2) + pow(imageView.bounds.size.height / 2.0 - point.y, 2)) < imageView.bounds.size.width / 2.0
    }

    override func updateLayout() {
        super.updateLayout()
        self.imageView.sizeToFit()
        self.imageView.center = CGPoint(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0)
    }

    public override func selectAnimation(animated: Bool, completion: (() -> Void)?) {
        let view = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 2.0, height: 2.0)))
        view.layer.cornerRadius = 1.0
        view.layer.opacity = 0.5
        view.backgroundColor = UIColor(red: 10 / 255.0, green: 66 / 255.0, blue: 91 / 255.0, alpha: 1.0)
        self.addSubview(view)
        playMaskAnimation(animateView: view, target: self.imageView, completion: {
            [weak view] in
            view?.removeFromSuperview()
            completion?()
        })
    }

    public override func reselectAnimation(animated: Bool, completion: (() -> Void)?) {
        completion?()
    }

    public override func deselectAnimation(animated: Bool, completion: (() -> Void)?) {
        completion?()
    }

    public override func highlightAnimation(animated: Bool, completion: (() -> Void)?) {
        UIView.beginAnimations("small", context: nil)
        UIView.setAnimationDuration(0.2)
        let transform = self.imageView.transform.scaledBy(x: 0.8, y: 0.8)
        self.imageView.transform = transform
        UIView.commitAnimations()
        completion?()
    }

    public override func dehighlightAnimation(animated: Bool, completion: (() -> Void)?) {
        UIView.beginAnimations("big", context: nil)
        UIView.setAnimationDuration(0.2)
        let transform = CGAffineTransform.identity
        self.imageView.transform = transform
        UIView.commitAnimations()
        completion?()
    }

    private func playMaskAnimation(animateView view: UIView, target: UIView, completion: (() -> Void)?) {
        view.center = CGPoint(x: target.frame.origin.x + target.frame.size.width / 2.0, y: target.frame.origin.y + target.frame.size.height / 2.0)

        let scale = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scale?.fromValue = NSValue(cgSize: CGSize(width: 1.0, height: 1.0))
        scale?.toValue = NSValue(cgSize: CGSize(width: 36.0, height: 36.0))
        scale?.beginTime = CACurrentMediaTime()
        scale?.duration = 0.3
        scale?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        scale?.removedOnCompletion = true

        let alpha = POPBasicAnimation(propertyNamed: kPOPLayerOpacity)
        alpha?.fromValue = 0.6
        alpha?.toValue = 0.6
        alpha?.beginTime = CACurrentMediaTime()
        alpha?.duration = 0.25
        alpha?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        alpha?.removedOnCompletion = true

        view.layer.pop_add(scale, forKey: "scale")
        view.layer.pop_add(alpha, forKey: "alpha")

        scale?.completionBlock = ({ animation, finished in
            completion?()
        })
    }

}
