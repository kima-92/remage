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
    
    var reminder: Reminder?
    
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
    }
    
    // MARK: - Methods
    
    private func tryLoadNote() {
        guard let reminder = reminder,
            let note = reminder.note else { return }
        
        noteTextView.text = note
    }
    
    private func updateViews() {
        // Round corners
        backgroundCardView.layer.cornerRadius = 15
        noteTextView.layer.cornerRadius = 15
        
        // TextView should start empty
        noteTextView.text = ""
    }
}
