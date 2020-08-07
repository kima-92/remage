//
//  AlarmTableViewCell.swift
//  Remage
//
//  Created by macbook on 8/5/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var themeController: ThemeController?
    
    var alarmDate: Date? {
        didSet  {
            updateViews()
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var alarmLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    
    // MARK: - Awake from Nib
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Methods
    
    private func updateViews() {
        //guard let alarmDate = alarmDate else { return }
        
        setBGColors()
    }
    
    // Background Colors Setup
    private func setBGColors() {
        
        // Get BGColor
        guard let themeController = themeController,
            let color = themeController.currentColor else { return }
        
        // Background
        backgroundColor = color.bgColor
        
        // DefaultImage
        pictureImageView.image = color.emptyPictureImage
    }
}
