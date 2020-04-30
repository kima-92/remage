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
    var reminder: Reminder? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var insideCellView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleTextField: UILabel!
    
    // MARK: - Methods
    func updateViews() {
        
        guard let reminder = reminder else { return }
        
        // Display the title or the description of the Reminder
        if reminder.title != "" {
            titleTextField.text = reminder.title
        } else {
            titleTextField.text = reminder.note
        }
        
        // TODO: - If the reminder has a default image, it
        // should display that in the thumbnailImageView
        
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
