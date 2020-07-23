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
    
    var imagePicker = UIImagePickerController()
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    
    @IBOutlet weak var addImagesButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var datePickerTextField: UITextField!
    @IBOutlet weak var timePickerTextField: UITextField!
    
    @IBOutlet weak var alarmSegmentedControl: UISegmentedControl!
    
    // MARK: - DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    // MARK: - Actions
    
    @IBAction func addImagesButtonTapped(_ sender: UIButton) {
        showCameraOrLibraryActionSheet()
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
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(cancelBarButtonPressed))
        
        // Add buttons to the toolbar
        toolbar.setItems([doneButton, flexSpace, cancel], animated: true)
        
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
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(cancelBarButtonPressed))
        
        // Add buttons to the toolbar
        toolbar.setItems([doneButton, flexSpace, cancel], animated: true)
        
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
    
    @objc private func cancelBarButtonPressed() {
        // End editing
        self.view.endEditing(true)
    }
    
    // Pick from Camera or PhotoLibrary Alert
    private func showCameraOrLibraryActionSheet() {
        
        // ActionSheet
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // Buttons
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let camera = UIAlertAction(title: "Camera", style: .default) { action in
            
            // s
        }
        
        let photoLibrary = UIAlertAction(title: "Photo Library", style: .default) { action in
            self.chooseImageFromLibrary()
        }
        
        // Add Buttons (Order matters)
        actionSheet.addAction(camera)
        actionSheet.addAction(photoLibrary)
        actionSheet.addAction(cancel)
        
        // Present the ActionSheet
        present(actionSheet, animated: true, completion: nil)
    }
    
    // Get Image from PhotoLibrary
    private func chooseImageFromLibrary() {
        
        // Set to Pick from PhotoLibrary
        imagePicker.sourceType = .photoLibrary
        
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
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
    
    // Can't save empty Reminder Alert
    func showMissingAlertDetails() {
        let alert = UIAlertController(title: "Nothing to Save", message: "Your reminder can't be saved until you enter an Image, a Title or a Note", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        // TODO: - The reminder should be able to save if it has either a title, a note or a default image
        
        self.present(alert, animated: true)
    }
    
    // MARK: - Update Views
    private func updateViews() {
        
        // Make sure the noteTextView is empty
        noteTextView.text = ""
        
        // Show image if the Reminder has one
        if let image = image {
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
        }
        
        imageView.layer.cornerRadius = 20
        addImagesButton.layer.cornerRadius = 15
        
        // TextFields Background colors
        titleTextField.backgroundColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 0.3)
        noteTextView.backgroundColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 0.3)
        datePickerTextField.backgroundColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 0.3)
        timePickerTextField.backgroundColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 0.3)
        
        // Create Pickers
        createDatePicker()
        createTimePicker()
        
        imagePicker.delegate = self
    }
}

// ImagePicker Delegate Protocols
extension NewReminderDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Try to get image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // If you can get an edited image
        if let image = info[.editedImage] as? UIImage {
            
            imageView.image = image
            
        // If you get the original Image
        } else if let image = info[.originalImage] as? UIImage {
            
            imageView.image = image
            
        }
        // Dismiss
        picker.dismiss(animated: true, completion: nil)
    }
    
    // If user decides to cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss
        picker.dismiss(animated: true, completion: nil)
    }
}
