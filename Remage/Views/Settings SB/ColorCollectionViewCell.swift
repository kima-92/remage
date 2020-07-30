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
    var color: BGColor?
    
    // MARK: - Outlets
    
    @IBOutlet weak var circlesView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // Circles
    @IBOutlet weak var leftCircleView: UIView!
    @IBOutlet weak var rightCircleView: UIView!
    @IBOutlet weak var bottomCircleView: UIView!
    
    // MARK: - Awake from Nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateViews()
    }
    
    // MARK: - Methods
    
    // Nib
    static func nib() -> UINib {
        return UINib(nibName: "ColorCollectionViewCell", bundle: nil)
    }
    
    // Update Views
    private func updateViews() {
        let circleSize = leftCircleView.bounds.height / 2.5
        
        // Round Corners
        self.contentView.layer.cornerRadius = 15
        self.contentView.layer.masksToBounds = true
        
        // Set Shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 5.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        
        // Round Circles
        leftCircleView.layer.cornerRadius = circleSize
        rightCircleView.layer.cornerRadius = circleSize
        bottomCircleView.layer.cornerRadius = circleSize
    }
    
    func setColors() {
        
        guard let color = color else { return }
        
        circlesView.backgroundColor = color.bgColor // cell background
        nameLabel.backgroundColor = color.textLabelColor
        nameLabel.textColor = color.fontColor
        
        // Circles
        leftCircleView.backgroundColor = color.bgCardColor
        rightCircleView.backgroundColor = color.color3
        
        if let lastColor = color.color9 {
            bottomCircleView.backgroundColor = lastColor
        } else if let lastColor = color.color8 {
            bottomCircleView.backgroundColor = lastColor
        } else {
            bottomCircleView.backgroundColor = color.color7
        }
        
        // Set Color Name
        nameLabel.text = color.name
    }
}
