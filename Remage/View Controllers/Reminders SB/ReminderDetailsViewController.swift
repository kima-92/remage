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
    
    var scrollView = UIScrollView()
    var scrollContentView = UIView()
    
    var titleLabel = UILabel()
    var noteTextView = UITextView()
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
        setTitleLabel()
        setNoteTextView()
        setPhotoImageView()
    }
    
    // Background Colors Setup
    private func setBGColors() {
        
        // Get BGColor
        guard let themeController = themeController,
            let color = themeController.currentColor else { return }
        
        // Background
        view.backgroundColor = color.bgColor
        
        // Views
        noteTextView.backgroundColor = color.textLabelColor
        noteTextView.textColor = color.fontColor
        titleLabel.textColor = color.fontColor
        
        // Set NavigationBar and TabBar Colors
        let textAttribute = [NSAttributedString.Key.foregroundColor: color.fontColor]
        navigationController?.navigationBar.titleTextAttributes = textAttribute
        
        navigationController?.navigationBar.tintColor = color.barTintColor
        navigationController?.navigationBar.barTintColor = color.barBGTintColor // Entire bar BG color
        
        tabBarController?.tabBar.barTintColor = color.barBGTintColor // Entire bar BG color
        tabBarController?.tabBar.tintColor = color.barTintColor // Selected tab bar button
        tabBarController?.tabBar.unselectedItemTintColor = color.barUnselectedTintColor // Unselected bar buttons
    }
    
    private func addSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        
        scrollContentView.addSubview(titleLabel)
        scrollContentView.addSubview(noteTextView)
        scrollContentView.addSubview(photoImageView)
    }
    
    private func setScrollView() {
        
        // 1.   Setup
        //scrollView.contentLayoutGuide
        
        // 2.   Constraint ScrollView
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
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
    
    // Title Label
    private func setTitleLabel() {
        guard let reminder = reminder else { return }
        
        // 1.   Text Attributes
        
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
        
        // 2.   Setup
        
        titleLabel.attributedText = attributedText
        titleLabel.textAlignment = .center
        
        // 3.   Constraint
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.topAnchor.constraint(equalTo: scrollContentView.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -20).isActive = true
    }
    
    private func setNoteTextView() {
        guard let reminder = reminder else { return }

        // 1.   Text Attributes

        var noteString = ""

        // From Reminder
        if let note = reminder.note,
            !note.isEmpty {

            noteString = "Note: \n\n" + note

        // Else, display No Note message
        } else {
            noteString = "No Note"
        }

        // Attributes
        let noteAttributes = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
        let attributedText = NSMutableAttributedString(string: noteString, attributes: noteAttributes)
        
        // 2.   Setup
        
        noteTextView.attributedText = attributedText
        noteTextView.textAlignment = .left
        
        noteTextView.layer.cornerRadius = 10
        
        // 3.   Constraint
        
        noteTextView.translatesAutoresizingMaskIntoConstraints = false
        
        noteTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        noteTextView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20).isActive = true
        noteTextView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -20).isActive = true
        noteTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setPhotoImageView() {
        
        // TODO: - Set photo's heigh bigger than it's width
        
        guard let reminder = reminder,
            let imageData = reminder.defaultImage,
            let image = UIImage(data: imageData) else { return }
        
        // 2.   Setup
        
        photoImageView.image = image
        photoImageView.contentMode = .scaleAspectFill
        
        // 3.   Constraint
        
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor, multiplier: 1.5).isActive = true
        
        photoImageView.topAnchor.constraint(equalTo: noteTextView.bottomAnchor, constant: 20).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -20).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: scrollContentView.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
}
