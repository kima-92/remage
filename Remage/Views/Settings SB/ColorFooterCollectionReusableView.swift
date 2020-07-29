//
//  ColorFooterCollectionReusableView.swift
//  Remage
//
//  Created by macbook on 7/29/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

class ColorFooterCollectionReusableView: UICollectionReusableView {
    
    // MARK: - Properties
    
    static let identifier = "ColorCVFooter"
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Footer"
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
    
    // To configure this Footer
    public func configure() {
        backgroundColor = .systemIndigo
        addSubview(label)
    }
}
