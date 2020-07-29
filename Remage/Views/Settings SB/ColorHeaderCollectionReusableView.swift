//
//  ColorHeaderCollectionReusableView.swift
//  Remage
//
//  Created by macbook on 7/29/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

class ColorHeaderCollectionReusableView: UICollectionReusableView {
    
    // MARK: - Properties
    
    static let identifier = "ColorCVHeader"
    
    private let label: UILabel = {
       let label = UILabel()
        label.text = "Header"
        label.textAlignment = .center
        label.textColor = .white
        
        return label
    }()
    
    // MARK: - Layout Subviews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = bounds
    }
    
    // MARK: - Methods
    
    // To configure this Header
    public func configure() {
        backgroundColor = .systemPurple
        addSubview(label)
    }
}
