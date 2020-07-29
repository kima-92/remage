//
//  ColorCollectionViewCell.swift
//  Remage
//
//  Created by macbook on 7/29/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "ColorCollectionViewCell"
    
    // MARK: - Awake from Nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .blue
    }
    
    // MARK: - Methods
    
    static func nib() -> UINib {
        return UINib(nibName: "ColorCollectionViewCell", bundle: nil)
    }
}
