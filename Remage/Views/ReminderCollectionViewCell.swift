//
//  ReminderCollectionViewCell.swift
//  Remage
//
//  Created by macbook on 4/29/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

class ReminderCollectionViewCell: UICollectionViewCell {
    
//    var reminder: Reminder? {
//        didSet {
//            updateViews()
//        }
//    }
    
    @IBOutlet weak var insideCellView: UIView!
    
    override func awakeFromNib() {
        updateViews()
    }
    
    func updateViews() {
        self.contentView.layer.cornerRadius = 2.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
}
