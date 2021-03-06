//
//  PhotoPreviewViewController.swift
//  Remage
//
//  Created by macbook on 7/3/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

protocol ImageSelectionDelegate {
    func didChoose(image: UIImage)
}

class PhotoPreviewViewController: UIViewController {
    
    // MARK: - Properties
    
    var controllers: ModelControllers?
    
    var image: UIImage?
    var didStartNewReminder: Bool?
    var nrDetailDelegate: ImageSelectionDelegate?
    
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
            
            // Find the NewReminderDetailVC
            for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: NewReminderDetailViewController.self) {
                    self.navigationController!.popToViewController(controller, animated: true)
                    
                    // Bring this image to the NewReminderDetailVC
                    if let nrDetailDelegate = nrDetailDelegate {
                        nrDetailDelegate.didChoose(image: image)
                    }
                    break
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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBackToRoot))
    }
    
    @objc private func goBackToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    // Background Colors Setup
    private func setBGColors() {
        guard let controllers = controllers,
            let color = controllers.themeController.currentColor else { return }
        setTabBarsBGColors(color: color)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Send image to PhotoPreviewVC
        if segue.identifier == "PhotoPreviewToNewReminderDetailSegue" {
            
            guard let newReminderDetailVC = segue.destination as? NewReminderDetailViewController else { return }
            newReminderDetailVC.imageFromCamera = image
            newReminderDetailVC.controllers = controllers
        }
    }
}
