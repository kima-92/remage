//
//  PhotoPreviewViewController.swift
//  Remage
//
//  Created by macbook on 7/3/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

class PhotoPreviewViewController: UIViewController {
    
    // MARK: - Properties
    
    var themeController: ThemeController?
    var reminderController: ReminderController?
    
    var image: UIImage?
    var didStartNewReminder: Bool?
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailsBarButton: UIBarButtonItem!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    // MARK: - DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBGColors()
    }
    
    // MARK: - Actions
    
    @IBAction func detailsBarButtonTapped(_ sender: UIBarButtonItem) {
        segueToAddDetails()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        savePhoto()
    }
    
    // MARK: - Methods
    
    // Segue to NewReminderDetailVC to add more details to this Reminder
    private func segueToAddDetails() {
        performSegue(withIdentifier: "PhotoPreviewToNewReminderDetailSegue", sender: self)
        
        // TODO: - From SettingsVC, allow the user to set if the image should be saved to the camera roll
        // after tapping on this button
        
        // Save the image in the Photo Library
        //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    // Save image in Photo Album and pop to a VC
    private func savePhoto() {
        guard let image = image else { return }
        
        // Save the image in the Photo Library
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        // If the user came from the NewReminderDetailVC,
        // pop to that NewReminderDetailVC
        if let didStartNewReminder = didStartNewReminder,
            didStartNewReminder {
            
            for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: NewReminderDetailViewController.self) {
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                    
                    // TODO: - Create a delegate protocol to bring this image to the NewReminderDetailVC
                }
            }
        // If the user did NOT come from the NewReminderDetailVC, popToRootVC
        } else {
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    // MARK: - Update Views
    
    private func updateViews() {
        guard let image = image else { return }
        imageView.image = image
        
        // Disabled the Details bar button if the User came from
        // NewReminderDetailVC
        if let didStartNewReminder = didStartNewReminder,
            didStartNewReminder {
            detailsBarButton.isEnabled = false
            detailsBarButton.tintColor = .clear
        }
    }
    
    // Background Colors Setup
    private func setBGColors() {
        
        // Get BGColor
        guard let themeController = themeController,
            let color = themeController.currentColor else { return }
        
        // Background
        view.backgroundColor = color.bgColor
        
        // Set NavigationBar and TabBar Colors
        let textAttribute = [NSAttributedString.Key.foregroundColor: color.fontColor]
        navigationController?.navigationBar.titleTextAttributes = textAttribute
        
        navigationController?.navigationBar.tintColor = color.barTintColor // Bar buttons
        navigationController?.navigationBar.barTintColor = color.barBGTintColor // Entire bar BG color
        
        tabBarController?.tabBar.barTintColor = color.barBGTintColor // Entire bar BG color
        tabBarController?.tabBar.tintColor = color.barTintColor // Selected tab bar button
        tabBarController?.tabBar.unselectedItemTintColor = color.barUnselectedTintColor // Unselected bar buttons
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Send image to PhotoPreviewVC
        if segue.identifier == "PhotoPreviewToNewReminderDetailSegue" {
            
            guard let newReminderDetailVC = segue.destination as? NewReminderDetailViewController else { return }
            newReminderDetailVC.imageFromCamera = image
            newReminderDetailVC.reminderController = reminderController
            newReminderDetailVC.themeController = themeController
        }
    }
}
