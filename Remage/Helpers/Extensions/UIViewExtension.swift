//
//  UIViewExtension.swift
//  Remage
//
//  Created by macbook on 9/22/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

extension UIView {
    
    func addShadow(opacity: Float, radius: CGFloat, color: UIColor = .black, shadowOffset: CGSize = .zero) {
        
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = radius
    }
}
