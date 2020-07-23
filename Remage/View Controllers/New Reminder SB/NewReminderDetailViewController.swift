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
    var image: UIImage?
    
    let datePicker = UIDatePicker()
    
    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    
    @IBOutlet weak var addImagesButton: UIButton!
    @IBOutlet weak var setAlertButton: UIButton!
    @IBOutlet weak var setDueDateButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var datePickerTextField: UITextField!
    
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
    
    // MARK: - Methods
    
    private func createDatePicker() {
        
        // Create the top tool bar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Bar Buttons
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        
        // Add buttons to the toolbar
        toolbar.setItems([doneButton], animated: true)
        
        // Assign toolbar keyboard as the input for the TextField
        datePickerTextField.inputAccessoryView = toolbar
        
        // Assign the datePicker to the textField
        datePickerTextField.inputView = datePicker
        
        
    }
    
    // Capture details to save a new Reminder
    func saveNewReminder() {
        // TODO: - The reminder should be able to save if it has either a titile, a note or a default image
        
        guard let title = titleTextField.text,
            let note = noteTextView.text else { return }
        
        let newImage = imageView.image
        
        // If either the Title or the Note are not empty,
        // save the reminder
        if !title.isEmpty || !note.isEmpty || newImage != nil {
            
            // Create new Reminder
            let reminder = Reminder(id: UUID().uuidString, context: CoreDataStack.shared.mainContext)
            reminder.title = title
            reminder.note = note
            reminder.defaultImage = newImage?.pngData()
            // TODO: - Save the default image to the reminder
            
            // Save reminder in Core Data
            CoreDataStack.shared.save(context: CoreDataStack.shared.mainContext)
            
            // Alert user the reminder is saved and pop back to root VC
            showReminderCreatedSuccessfullyAlert()
        }
        else {
            // Alert user that the Reminder is empty
            showMissingAlertDetails()
        }
    }
    
    // Alert the user the new Reminder has been saved
    func showReminderCreatedSuccessfullyAlert() {
        let alert = UIAlertController(title: "Done!", message: "Reminder saved Successfully", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Go Back", style: .default, handler: { action in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        self.present(alert, animated: true)
    }
    
    // Alert for empty Reminder before saving
    func showMissingAlertDetails() {
        let alert = UIAlertController(title: "Nothing to Save", message: "Your reminder can't be saved until you enter an Image, a Title or a Note", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        // TODO: - The reminder should be able to save if it has either a titile, a note or a default image
        
        self.present(alert, animated: true)
    }
    
    // MARK: - Update Views
    func updateViews() {
        
        // Make sure the noteTextView is empty
        noteTextView.text = ""
        
        if let image = image {
            imageView.image = image
        }
        
        createDatePicker()
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
