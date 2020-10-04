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
    
    var controllers: ModelControllers?
    
    var reminder: Reminder?
    
    var scrollView = UIScrollView()
    var scrollContentView = UIView()
    
    var noteLabel = UILabel()
    var alarmLabel = UILabel()
    var photoImageView = UIImageView()
    
    // MARK: - DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBGColors()
    }
    
    // MARK: - Update Views
    
    private func updateViews() {
        addSubViews()
        
        setScrollView()
        setNoteLabel()
        setAlarmLabel()
        setPhotoImageView()
    }
    
    // Background Colors Setup
    private func setBGColors() {
        // Get BGColor
        guard let controllers = controllers,
            let color = controllers.themeController.currentColor else { return }
        
        // Background
        setTabBarsBGColors(color: color)
        
        // Views
        noteLabel.backgroundColor = color.textLabelColor
        noteLabel.textColor = color.fontColor
    }
    
    private func addSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        
        scrollContentView.addSubview(noteLabel)
        scrollContentView.addSubview(alarmLabel)
        scrollContentView.addSubview(photoImageView)
    }
    
    private func setScrollView() {
        
        // 1.   Setup
        //scrollView.contentLayoutGuide
        
        // 2.   Constraint ScrollView
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        // Top & Bottom
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        // Leading & Trailing
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        // 3.   Constraint ScrollContentView
        
        scrollContentView.translatesAutoresizingMaskIntoConstraints = false
        
        // Top & Bottom
        scrollContentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        // Leading & Trailing
        scrollContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        
        // Width & Height
        scrollContentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        let heightConstraint = scrollContentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        
            heightConstraint.priority = UILayoutPriority(rawValue: 250)
            heightConstraint.isActive = true
    }
    
    private func setNoteLabel() {
        guard let reminder = reminder else { return }

        // 1.   Text Attributes

        var noteString = ""

        // From Reminder
        if let note = reminder.note,
            !note.isEmpty {

            noteString = "Note: \n\n" + note

        // Else, display default message
        } else {
            noteString = "Edit to add Notes here"
        }

        // Attributes
        let font = UIFont.boldSystemFont(ofSize: 18)
        let noteAttributes = [NSAttributedString.Key.font : font]
        let attributedText = NSMutableAttributedString(string: noteString, attributes: noteAttributes)
        
        // 2.   Setup
        
        noteLabel.attributedText = attributedText
        noteLabel.textAlignment = .left
        noteLabel.numberOfLines = 0
        
        noteLabel.layer.cornerRadius = 10
        noteLabel.clipsToBounds = true
        
        // 3.   Constraint
        
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Top
        noteLabel.topAnchor.constraint(equalTo: scrollContentView.safeAreaLayoutGuide.bottomAnchor, constant: 20).isActive = true
        // Leading & Trailing
        noteLabel.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20).isActive = true
        noteLabel.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -20).isActive = true
        
        // Height
        
        // Configure based on how much text needs to be displayed
        let height: CGFloat = DynamicLabelHeight.heighWith(attributedText: attributedText, width: view.frame.width)
        
        noteLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setAlarmLabel() {
        
        guard let reminder = reminder else { return }
        
        // 1.   Setup
        
        if reminder.alarmOn {
            guard let alarmDate = reminder.alarmDate else { return }
        // Set Formatter
        
        // Create formatter
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MMMM dd, yyyy h:mm a"
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        let dateString = formatter.string(from: alarmDate)
        
        
        // 4.   Make a Date for this reminder's alarmDate
        
//        let string = dateString + " " + timeString
//        let date = formatter.date(from: string)
        
//        guard let finalDate = date else { return nil }
//        return finalDate
        
            alarmLabel.text = "Alarm set for \(dateString)"
        } else {
            alarmLabel.text = "Alarm off"
        }
        
        // 2.   Constraint
        
        alarmLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Top & Bottom
        alarmLabel.topAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 20).isActive = true
//        alarmLabel.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: -20).isActive = true
        
        // Leading & Trailing
        alarmLabel.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20).isActive = true
        alarmLabel.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -20).isActive = true
    }
    
    private func setPhotoImageView() {
        
        guard let reminder = reminder,
            let imageData = reminder.defaultImage,
            let image = UIImage(data: imageData) else { return }
        
        // 2.   Setup
        
        photoImageView.image = image
        photoImageView.contentMode = .scaleAspectFill
        
        // 3.   Constraint
        
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor, multiplier: 1.5).isActive = true
        
        photoImageView.topAnchor.constraint(equalTo: alarmLabel.bottomAnchor, constant: 20).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -20).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: scrollContentView.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
}
