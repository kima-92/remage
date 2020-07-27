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
    
    private func sendNoteToReminder() {
        
        guard let note = noteTextView.text,
                !note.isEmpty
            else {
                // TODO: - Alert User
                return
        }
        getNoteDelegate.get(note: note)
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
