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
    
    // MARK: - DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        savePhoto()
    }
    
    // MARK: - Methods
    
    // Save image in Photo Album
    private func savePhoto() {
        guard let image = image else { return }
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        if let didStartNewReminder = didStartNewReminder,
            didStartNewReminder {
            
            for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: NewReminderDetailViewController.self) {
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                    
                    // TODO: - Create a delegate protocol to bring this image to the NewReminderDetailVC
                }
            }
        } else {
            navigationController?.popToRootViewController(animated: true)
            
            // TODO: - Create a new button for "Details" in case the user wants to edit the details right now
            // The "Save" button should say "Save photo only" or something like that cause it will popToRootVC
        }
        //performSegue(withIdentifier: "PhotoPreviewToNewReminderDetailSegue", sender: self)
    }
    
    private func updateViews() {
        guard let image = image else { return }
        imageView.image = image
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
