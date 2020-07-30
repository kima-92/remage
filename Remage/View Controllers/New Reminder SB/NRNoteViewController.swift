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
    var reminderController: ReminderController?
    
    var note: String?
    var getNoteDelegate: GetNoteDelegate!
    
    // MARK: - Outlets
    
    @IBOutlet weak var addNoteLabel: UILabel!
    @IBOutlet weak var backgroundCardView: UIView!
    @IBOutlet weak var noteTextView: UITextView!
    
    // MARK: - DidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        tryLoadNote()
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
    }
}

// MARK: - Protocol

// Pass the Note to NewReminderDetailVC
protocol GetNoteDelegate {
    func get(note: String)
}
