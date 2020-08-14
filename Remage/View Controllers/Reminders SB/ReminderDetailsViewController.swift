//
//  ReminderDetailsViewController.swift
//  Remage
//
//  Created by macbook on 8/13/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

class ReminderDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    var themeController: ThemeController?
    var reminderController: ReminderController?
    
    var reminder: Reminder?
    
    var titleLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Update Views
    
    private func updateViews() {
        setTitleLabel()
    }
    
    // Title Label
    private func setTitleLabel() {
        guard let reminder = reminder else { return }
        
        // 1.   Set Text Attributes
        
        var titleString = ""
        
        // From Reminder
        if let title = reminder.title,
            !title.isEmpty {
            
            titleString = title
            
        // Else, display Empty Title message
        } else {
            titleString = "Update Title"
        }
        
        // Attributes
        let titleAttributes = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
        let attributedText = NSMutableAttributedString(string: titleString, attributes: titleAttributes)
        
        // 2.   Create Label
        
        titleLabel = {
            let label = UILabel()
            
            // Add Attributes
            label.attributedText = attributedText
            
            // Setup
            label.textAlignment = .center
            view.addSubview(label)
            
            return label
        }()
        
        // 3.   Constraint
        
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel?.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        titleLabel?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleLabel?.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant: -20).isActive = true
        titleLabel?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20).isActive = true
    }
}
