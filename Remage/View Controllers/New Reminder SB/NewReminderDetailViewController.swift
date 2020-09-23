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
    
    var controllers: ModelControllers?
    var cameraController: CameraController?
    
    var image: UIImage?
    var imageFromCamera: UIImage?
    var imageFromLibrary: UIImage?
    var emptyPhotoImage: UIImage?
    
    var noteRecieved: String?
    var oldNote: String?
    var didShowNewNoteAlert = false
    var didStartNewReminder = true
    
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    
    var imagePicker = UIImagePickerController()
    
    var reminder: Reminder?
    var date: Date?
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backgroundCardView: UIView!
    
    @IBOutlet weak var alarmLabel: UILabel!
    @IBOutlet weak var alarmSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var addImagesButton: UIButton!
    @IBOutlet weak var addPictureLabel: UILabel!
    @IBOutlet weak var addNoteButton: UIButton!
    @IBOutlet weak var addNoteLabel: UILabel!
    
    // MARK: - DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBGColors()
        tryDisplayImageFromCamera()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tryShowNoteRecivedAlert()
    }
    
    // MARK: - Actions
    @IBAction func alarmSegmentedControlToggled(_ sender: UISegmentedControl) {
        guard let controllers = controllers  else { return }
        let permission = controllers.reminderController.permissionGranted
        
        // If we don't have permission, don't allow the User to turn on the Alarm SegmentedControl
        if let permission = permission,
            !permission {
            showDontHavePermission()
            alarmSegmentedControl.selectedSegmentIndex = 0
        }
    }
    
    @IBAction func addImagesButtonTapped(_ sender: UIButton) {
        addImagesButton.pulsateOnce()
        showCameraOrLibraryActionSheet()
    }
    
    @IBAction func addNoteButtonTapped(_ sender: UIButton) {
            addImagesButton.pulsateOnce()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        saveNewReminder()
    }
    
    // MARK: - Pickers
    
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
        //datePickerTextField.inputAccessoryView = toolbar
        
        // Assign the datePicker to the textField
        //datePickerTextField.inputView = datePicker
        
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
        //timePickerTextField.inputAccessoryView = toolbar
        
        // Assign the timePicker to the textField
        //timePickerTextField.inputView = timePicker
        
        // Set time as datePicker's mode
        timePicker.datePickerMode = .time
    }
    
    // Date Done Button
    @objc private func dateDoneBarButtonPressed() {
        
        guard let controllers = controllers else { return }
        
        // DateFormatter
        let formatter = DateFormatter()
        // Date Style
        formatter.dateStyle = .medium
        // Don't need to display time
        formatter.timeStyle = .none
        
        // Get date as string from Picker using the formatter
        let dateString = formatter.string(from: datePicker.date)
        
        // Add formatted date to textField
//        datePickerTextField.text = dateString
        
        // End editing
        self.view.endEditing(true)
        
        // Try to set the Segmented control by checking if we have permission
        if let permission = controllers.reminderController.permissionGranted,
            permission {
            alarmSegmentedControl.selectedSegmentIndex = 1
        } else {
            self.showDontHavePermission()
        }
    }
    
    // Time Done Button
    @objc private func timeDoneBarButtonPressed() {
        
        guard let controllers = controllers else { return }
        
        // DateFormatter
        let formatter = DateFormatter()
        // Don't need to display date
        formatter.dateStyle = .none
        // Time Style
        formatter.timeStyle = .short
        
        // Get time as string from Picker using the formatter
        let timeString = formatter.string(from: timePicker.date)
        
        // Add formatted time to textField
//        timePickerTextField.text = timeString
        
        // End editing
        self.view.endEditing(true)
        
        // Try to set the Segmented control by checking if we have permission
        if let permission = controllers.reminderController.permissionGranted,
            permission {
            alarmSegmentedControl.selectedSegmentIndex = 1
        } else {
            self.showDontHavePermission()
        }
    }
    
    // CancelBarButton for TimePicker and DatePicker
    @objc private func cancelBarButtonPressed() {
        // End editing
        self.view.endEditing(true)
    }
    
    // MARK: - Methods
    
    // If recieved the image from the camera, display it
    private func tryDisplayImageFromCamera() {
        if let image = imageFromCamera {
            imageView.image = image
        }
    }
    
    // Alert User if the Note was recived
    private func tryShowNoteRecivedAlert() {
        
        // If Recived a new Note
        if noteRecieved != nil && didShowNewNoteAlert == false {
            
            showReceivedNoteAlert()
            didShowNewNoteAlert = true
            oldNote = noteRecieved
        }
            
        // Else, if recieved an updated Note
        else if noteRecieved != oldNote {
            showUpdatedNoteAlert()
            oldNote = noteRecieved
        }
    }
    
    // Set alarm
    private func setAlarm() -> Date? {
        
        // 1.   Create formatter
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy h:mm a"
        
        // 2.   Grab the date
        
        // DateFormatter
        let dateFormatter = DateFormatter()
        // Date Style
        dateFormatter.dateStyle = .medium
        // Don't want time in this formatter
        dateFormatter.timeStyle = .none
        // Get date as string from Picker using the formatter
        let dateString = dateFormatter.string(from: datePicker.date)
        
        // 3.   Grab the Time
        
        // TimeFormatter
        let timeFormatter = DateFormatter()
        // Don't need date in this formatter
        timeFormatter.dateStyle = .none
        // Time Style
        timeFormatter.timeStyle = .short
        // Get time as string from Picker using the formatter
        let timeString = timeFormatter.string(from: timePicker.date)
        
        // 4.   Make a Date for this reminder's alarmDate
        
        let string = dateString + " " + timeString
        let date = formatter.date(from: string)
        
        guard let finalDate = date else { return nil }
        return finalDate
    }
    
    // Pick from Camera or PhotoLibrary Alert
    private func showCameraOrLibraryActionSheet() {
        
        // ActionSheet
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // Buttons
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let camera = UIAlertAction(title: "Camera", style: .default) { action in
            
            // Go to CameraVC
            self.performSegue(withIdentifier: "ShowCameraFromNRDetailsVC", sender: self)
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
    private func saveNewReminder() {
        
        guard let controllers = controllers else  {
//            let title = titleTextField.text else {
            showCantSaveReminder()
            return
        }
        
        // Get image if it's not one of the default Images
        let lightImage = UIImage(named: "lightEmptyPicture")
        let darkImage = UIImage(named: "darkEmptyPicture")
        
        if imageView.image != lightImage && imageView.image != darkImage {
            image = imageView.image
        }
        
        // Try to save the reminder
        if image != nil || noteRecieved != nil {
//            if !title.isEmpty || image != nil || noteRecieved != nil {
            
            // Set Alarm if AlarmSegment is On
            if alarmSegmentedControl.selectedSegmentIndex == 1 {
                
                self.date = setAlarm()
                guard let date = date else { return }
                
                controllers.reminderController.saveNewReminderWith(alarmDate: date, title: "", defaultImage: image?.pngData(), note: noteRecieved)
                
            // Else save Reminder without an Alarm
            } else {
                controllers.reminderController.saveNewReminder(title: "", defaultImage: image?.pngData(), note: noteRecieved)
            }
            
            // Alert user the reminder is saved, and pop back to root VC
            showReminderCreatedSuccessfullyAlert()
        }
        else {
            // Alert user that the Reminder is empty
            showMissingAlertDetails()
        }
    }
    
    // MARK: - Alerts
    
    // Alert the user the new Reminder has been saved
    private func showReminderCreatedSuccessfullyAlert() {
        let alert = UIAlertController(title: "Done!", message: "Reminder saved Successfully", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Go Back", style: .default, handler: { action in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        self.present(alert, animated: true)
    }
    
    // Can't save empty Reminder Alert
    private func showMissingAlertDetails() {
        let alert = UIAlertController(title: "Nothing to Save", message: "Your reminder can't be saved until you enter an Image, a Title or a Note", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        // TODO: - The reminder should be able to save if it has either a title, a note or a default image
        
        self.present(alert, animated: true)
    }
    
    // Can't save Reminder Alert
    private func showCantSaveReminder() {
        let alert = UIAlertController(title: "Oops!", message: "Something when't wrong, couldn't save this reminder. Please try again.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    // We don't have permission for Local Notifications
    private func showDontHavePermission() {
        let alert = UIAlertController(title: "Remage does not have Permission", message: "Please go to Settings and allow Remage send Notifications to your device.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    // Recieved New Note
    private func showReceivedNoteAlert() {
        let alert = UIAlertController(title: "Saved!", message: "A Note has been added to this Reminder", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    // Updated Note
    private func showUpdatedNoteAlert() {
        let alert = UIAlertController(title: "Saved Changes!", message: "The Note has been updated successfully", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    // MARK: - Update Views
    
    private func updateViews() {
        
        // Round corners
        addImagesButton.layer.cornerRadius = addImagesButton.bounds.width / 2
        addNoteButton.layer.cornerRadius = addNoteButton.bounds.width / 2
        backgroundCardView.layer.cornerRadius = 20
        
        // Shadow
        backgroundCardView.addShadow(opacity: 1, radius: 10)
        addImagesButton.addShadow(opacity: 0.5, radious: 5)
        addNoteButton.addShadow(opacity: 0.5, radious: 5)
        
        // Create Pickers
        createDatePicker()
        createTimePicker()
        
        // Set Delegates
        imagePicker.delegate = self
    }
    
    // Background Colors Setup
    private func setBGColors() {
        // Get BGColor
        guard let controllers = controllers,
            let color = controllers.themeController.currentColor else { return }
        
        // Background
        setTabBarsBGColors(color: color)
        backgroundCardView.backgroundColor = color.bgCardColor
//        
//        // Pickers
//        datePickerTextField.backgroundColor = color.textLabelColor
//        timePickerTextField.backgroundColor = color.textLabelColor
        
        // Segmented Control
        let textAttributes = [NSAttributedString.Key.foregroundColor: color.fontColor]
        alarmSegmentedControl.setTitleTextAttributes(textAttributes, for: .normal)
        alarmSegmentedControl.selectedSegmentTintColor = color.color8
        
        // Set Buttons Images
        addImagesButton.setBackgroundImage(color.cameraImage, for: .normal)
        addNoteButton.setBackgroundImage(color.docImage, for: .normal)
        
        addImagesButton.backgroundColor = color.bgColor
        addNoteButton.backgroundColor = color.bgColor
        
        // Image
        if imageFromCamera == nil && imageFromLibrary == nil {
            imageView.image = color.emptyPictureImage
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Segue to NRNote
        if segue.identifier == "AddNewNoteSegue" {
            guard let noteVC = segue.destination as? NRNoteViewController,
                let controllers = controllers else { return }
            
            noteVC.note = noteRecieved
            noteVC.getNoteDelegate = self
            noteVC.themeController = controllers.themeController
        }
            
        // Segue to CameraVC
        else if segue.identifier == "ShowCameraFromNRDetailsVC" {
            guard let cameraVC = segue.destination as? CameraViewController else { return }
            
            cameraVC.controllers = controllers
            cameraVC.cameraController = cameraController
            
            cameraVC.didStartNewReminder = didStartNewReminder
            cameraVC.nrDetailDelegate = self
        }
    }
}

// MARK: - Extensions

// ImagePicker Delegate Protocols
extension NewReminderDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // Try to get image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // If you can get an edited image
        if let image = info[.editedImage] as? UIImage {
            
            imageFromLibrary = image
            imageView.image = image
            
        // If you get the original Image
        } else if let image = info[.originalImage] as? UIImage {
            
            imageFromLibrary = image
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

// Getting the Note for this Reminder from NRNoteVC
extension NewReminderDetailViewController: GetNoteDelegate {
    func get(note: String) {
        noteRecieved = note
    }
}

// Get the image from PhotoPreviewVC
extension NewReminderDetailViewController: ImageSelectionDelegate {
    func didChoose(image: UIImage) {
        imageFromCamera = image
    }
}
