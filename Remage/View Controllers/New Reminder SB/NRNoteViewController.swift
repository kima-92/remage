//
//  NRNoteViewController.swift
//  Remage
//
//  Created by macbook on 7/27/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

class NRNoteViewController: UIViewController {
    
    // MARK: - Properties
    
    var themeController: ThemeController?
    
    var note: String?
    var getNoteDelegate: GetNoteDelegate!
    
    // MARK: - Outlets
    
    @IBOutlet weak var scrollSubView: UIView!
    @IBOutlet weak var scrollPushingView: UIView!
    
    @IBOutlet weak var addNoteLabel: UILabel!
    @IBOutlet weak var backgroundCardView: UIView!
    @IBOutlet weak var noteTextView: UITextView!
    
    // MARK: - DidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        tryLoadNote()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBGColors()
    }
    
    // MARK: - Actions
    
    @IBAction func saveBarButtonTapped(_ sender: UIBarButtonItem) {
        sendNoteToReminder()
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Methods
    
    private func tryLoadNote() {
        guard let note = note else { return }
        
        noteTextView.text = note
    }
    
    // Send Note via GetNoteDelegate Protocol
    private func sendNoteToReminder() {
        
        // Try to send Note
        if let note = noteTextView.text,
            !note.isEmpty {
            
            getNoteDelegate.get(note: note)
            
        // Else alert user
        } else {
            showCantSaveNote()
            return
        }
    }
    
    // Can't save Note Alert
    private func showCantSaveNote() {
        let alert = UIAlertController(title: "Oops!", message: "Something when't wrong, couldn't save this Note. Please try again.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    // MARK: - UpdateViews
    
    private func updateViews() {
        
        // Round corners
        backgroundCardView.layer.cornerRadius = 15
        noteTextView.layer.cornerRadius = 15
        
        // TextView should start empty
        noteTextView.text = ""
        
        // Set Background Colors
        setBGColors()
        
    }
    
    // Background Colors Setup
    private func setBGColors() {
        
        // Get BGColor
        guard let themeController = themeController,
            let color = themeController.currentColor else { return }
        
        // Background
        view.backgroundColor = color.bgColor
        scrollSubView.backgroundColor = color.bgColor
        scrollPushingView.backgroundColor = color.bgColor
        backgroundCardView.backgroundColor = color.bgCardColor
        
        // TextView
        noteTextView.backgroundColor = color.textLabelColor
        noteTextView.textColor = color.fontColor
        //noteTextView.textInputView.tintColor = color.fontColor
        
        // Label
        addNoteLabel.textColor = color.fontColor
    }
}

// MARK: - Protocol

// Pass the Note to NewReminderDetailVC
protocol GetNoteDelegate {
    func get(note: String)
}
