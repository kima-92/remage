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
    var noteLabel = UILabel()
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
        noteLabel.backgroundColor = color.textLabelColor
        noteLabel.textColor = color.fontColor
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
        scrollContentView.addSubview(noteLabel)
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
        noteLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        // Leading & Trailing
        noteLabel.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20).isActive = true
        noteLabel.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -20).isActive = true
        
        // Height
        
        // Configure based on how much text needs to be displayed
        let height: CGFloat = DynamicLabelHeight.heighWith(attributedText: attributedText, width: view.frame.width)
        
        noteLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
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
        
        photoImageView.topAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 20).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 20).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -20).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: scrollContentView.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
}
