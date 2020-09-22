//
//  UIButtonExtension.swift
//  Remage
//
//  Created by macbook on 9/22/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

extension UIButton {

    // Animations
    
    func pulsateOnce() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 0.97
        pulse.toValue = 0.99
        pulse.autoreverses = false
        pulse.repeatCount = .zero
        pulse.initialVelocity = 0.1
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
    
    func pulsateInfinity() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 0.98
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
    
    func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.3
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 2
        layer.add(flash, forKey: nil)
    }
    
    // Shadow
    
    func addShadow(opacity: Float, radious: CGFloat, color: UIColor = .black, shadowOffset: CGSize = .zero) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = radious
    }
}
