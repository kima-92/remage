//
//  ReminderCollectionViewCell.swift
//  Remage
//
//  Created by macbook on 4/29/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

class ReminderCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var color: BGColor?
    
    var reminder: Reminder? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var insideCellView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Methods
    
    private func updateViews() {
        
        guard let reminder = reminder else { return }
        
        // Try to display the Note
        titleLabel.text = reminder.note != nil ? reminder.note : ""
        
        // Display Reminder's Picture
        if let image = reminder.defaultImage {
            
            thumbnailImageView.image = UIImage(data: image)
            thumbnailImageView.contentMode = .scaleAspectFill
//            thumbnailImageView.image?.imageOrientation =
        
        // Else display the emptyImage Picture
        } else {
            guard let color = color else { return }
            
            thumbnailImageView.backgroundColor = color.bgColor
            thumbnailImageView.image = color.emptyPictureImage
        }
        
        thumbnailImageView.layer.cornerRadius = 8.0
        
        // Setting the Cell's shawdow
        self.contentView.layer.cornerRadius = 8.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        
        self.layer.shadowPath = UIBezierPath(roundedRect: thumbnailImageView.bounds, cornerRadius: thumbnailImageView.layer.cornerRadius).cgPath
    }
}
