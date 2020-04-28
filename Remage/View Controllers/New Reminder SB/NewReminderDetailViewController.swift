//
//  NewReminderDetailViewController.swift
//  Remage
//
//  Created by macbook on 4/27/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

class NewReminderDetailViewController: UIViewController {
    
    // MARK: - Properties
    var cdModelController: CoreDataModelController?
    
    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    
    @IBOutlet weak var addImagesButton: UIButton!
    @IBOutlet weak var setAlertButton: UIButton!
    @IBOutlet weak var setDueDateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func addImagesButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func setAlertButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func setDueDateButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        saveNewReminder()
    }
    
    // Capture details to save a new Reminder
    func saveNewReminder() {
        // TODO: - The reminder should be able to save if it has either a titile, a note or a default image
        
        guard let title = titleTextField.text,
            let note = noteTextView.text else { return }
        
        // If either the Title or the Note are not empty,
        // save the reminder
        if !title.isEmpty || !note.isEmpty {
            
            // Create new Reminder
            let reminder = Reminder(id: UUID().uuidString, context: CoreDataStack.shared.mainContext)
            reminder.title = title
            reminder.note = note
            // TODO: - Save the default image to the reminder
            
            // Save reminder in Core Data
            CoreDataStack.shared.save(context: CoreDataStack.shared.mainContext)
            
        }
        else {
            // Alert user that the Reminder is empty
            showMissingAlertDetails()
        }
    }
    
    // Alert for empty Reminder before saving
    func showMissingAlertDetails() {
        let alert = UIAlertController(title: "Nothing to Save", message: "Your reminder can't be saved until you enter at least a Title or a Note", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        // TODO: - The reminder should be able to save if it has either a titile, a note or a default image
        
        self.present(alert, animated: true)
    }
    
    // MARK: - Update Views
    func updateViews() {
        
        // Make sure the noteTextView is empty
        noteTextView.text = ""
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
