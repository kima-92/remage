//
//  NewReminderTypeViewController.swift
//  Remage
//
//  Created by macbook on 4/27/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

class NewReminderTypeViewController: UIViewController {
    
    // MARK: - Properties
    let reminderController = ReminderController()
    let cameraController = CameraController()  // TODO: - Should initiate at initial screen, and pass to this VC
    
    // MARK: - Outlets
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var noteButton: UIButton!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func cameraButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func noteButtonPressed(_ sender: UIButton) {
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Segue to CameraVC
        if segue.identifier == "ShowCameraVCSegue" {
            guard let cameraVC = segue.destination as? CameraViewController else { return }
            
            cameraVC.reminderController = reminderController
            cameraVC.cameraController = cameraController
        }
        
        // Segue to NewReminderDetailVC
        else if segue.identifier == "ShowNewReminderDetailVCSegue" {
            guard let newReminderDetailVC = segue.destination as? NewReminderDetailViewController else { return }
            
            newReminderDetailVC.reminderController = self.reminderController
        }
    }
}
