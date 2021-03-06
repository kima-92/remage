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
    var reminderController: ReminderController?
    
    var reminder: Reminder? {
        didSet  {
            updateViews()
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var alarmLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    // MARK: - Awake from Nib
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Actions
    
    @IBAction func alarmSwitchChanged(_ sender: UISwitch) {
        turnAlarmOnOrOff(sender: sender)
    }
    
    // MARK: - Methods
    
    private func turnAlarmOnOrOff(sender: UISwitch) {
        
        guard let reminderController = reminderController,
            let reminder = reminder else {
                alarmSwitch.setOn(!sender.isOn, animated: true)
                // TODO: - Present an alert to the user
                return
        }
        if sender.isOn {
            reminderController.turnAlarmOnFor(reminder: reminder)
        } else {
            reminderController.turnAlarmOffFor(reminder: reminder)
        }
    }
    
    private func updateViews() {
        
        guard let reminder = reminder,
            let alarmDate = reminder.alarmDate else { return }
        
        // Set BGColor
        setBGColors()
        
        // Description Label
        titleLabel.text = reminder.note != nil ? reminder.note : ""
        
        // Alarm Label
        
        // Date Formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        // Get date as string
        let dateString = formatter.string(from: alarmDate)
        // Add formatted date to Label
        alarmLabel.text = dateString
        
        // Picture ImageView
        if let imageData = reminder.defaultImage,
            let image = UIImage(data: imageData) {
            pictureImageView.image = image
        }
        
        // Switch
        alarmSwitch.setOn(reminder.alarmOn, animated: false)
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
        
        // Colors
        titleLabel.textColor = color.fontColor
        alarmLabel.textColor = color.fontColor
    }
}
