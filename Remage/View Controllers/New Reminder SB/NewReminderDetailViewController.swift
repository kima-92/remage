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
    let timePicker = UIDatePicker()
    
    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    
    @IBOutlet weak var addImagesButton: UIButton!
    @IBOutlet weak var setAlertButton: UIButton!
    @IBOutlet weak var setDueDateButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var datePickerTextField: UITextField!
    @IBOutlet weak var timePickerTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func addImagesButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func setAlertButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        saveNewReminder()
    }
    
    // MARK: - Methods
    
    // Date Picker
    private func createDatePicker() {
        
        // Create the top tool bar on keyboard
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Bar Buttons
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dateDoneBarButtonPressed))
        
        // Add buttons to the toolbar
        toolbar.setItems([doneButton], animated: true)
        
        // Assign toolbar keyboard as the input for the TextField
        datePickerTextField.inputAccessoryView = toolbar
        
        // Assign the datePicker to the textField
        datePickerTextField.inputView = datePicker
        
        // Set date as datePicker's mode
        datePicker.datePickerMode = .date
    }
    
    // Time Picker
    private func createTimePicker() {
        
        // Create the top tool bar on keyboard
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Bar Buttons
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timeDoneBarButtonPressed))
        
        // Add buttons to the toolbar
        toolbar.setItems([doneButton], animated: true)
        
        // Assign toolbar keyboard as the input for the TextField
        timePickerTextField.inputAccessoryView = toolbar
        
        // Assign the timePicker to the textField
        timePickerTextField.inputView = timePicker
        
        // Set time as datePicker's mode
        timePicker.datePickerMode = .time
    }
    
    // Date Done Button
    @objc private func dateDoneBarButtonPressed() {
        
        // DateFormatter
        let formatter = DateFormatter()
        // Date Style
        formatter.dateStyle = .medium
        // Don't need to display time
        formatter.timeStyle = .none
        
        // Get date as string from Picker using the formatter
        let dateString = formatter.string(from: datePicker.date)
        
        // Add formatted date to textField
        datePickerTextField.text = dateString
        
        // End editing
        self.view.endEditing(true)
    }
    
    // Time Done Button
    @objc private func timeDoneBarButtonPressed() {
        
        // DateFormatter
        let formatter = DateFormatter()
        // Don't need to display time
        formatter.dateStyle = .none
        // Time Style
        formatter.timeStyle = .short
        
        // Get time as string from Picker using the formatter
        let timeString = formatter.string(from: timePicker.date)
        
        // Add formatted time to textField
        timePickerTextField.text = timeString
        
        // End editing
        self.view.endEditing(true)
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
        createTimePicker()
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
