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
    
    // MARK: - Outlets
    
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - Awake from Nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCircle()
        updateViews()
    }
    
    // MARK: - Methods
    
    // Nib
    static func nib() -> UINib {
        return UINib(nibName: "ColorCollectionViewCell", bundle: nil)
    }
    
    // Update Views
    private func updateViews() {
        
        // Background Color
        circleView.backgroundColor = .blue
        //backgroundColor = .blue
        
        // Round Corners
        self.contentView.layer.cornerRadius = 15
        self.contentView.layer.masksToBounds = true
        
        // Set Shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 5.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
    }
    
    // Circle Setup
    private func setupCircle()  {
        let circleLayer = CAShapeLayer()
        
        // Center of Cell
        let center = CGPoint(x: self.frame.maxX * 1.85, y: self.frame.maxY * 1.5)
        
        // Circle's Path
        let circularPath = UIBezierPath(arcCenter: center, radius: self.bounds.height, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        // Add Path
        circleLayer.path = circularPath.cgPath
        
        // Set Stroke Color
        circleLayer.strokeColor = UIColor.red.cgColor
        circleLayer.lineWidth = 20
        
        // Set Color
        circleLayer.fillColor = UIColor.green.cgColor
        
        circleView.layer.addSublayer(circleLayer)
    }
}
