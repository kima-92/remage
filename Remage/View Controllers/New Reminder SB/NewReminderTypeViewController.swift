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
    
    var controllers: ModelControllers?
    let cameraController = CameraController()  // TODO: - Should initiate at initial screen, and pass to this VC
    
    // MARK: - Outlets
    
    @IBOutlet weak var cameraBGCardView: UIView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var takePictureLabel: UILabel!
    
    @IBOutlet weak var noteBGCardView: UIView!
    @IBOutlet weak var noteButton: UIButton!
    @IBOutlet weak var createWithNotesLabel: UILabel!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        receiveDataFromTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBGColors()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        controllers?.reminderController.turnOffAllDeliveredNotifications()
    }
    
    // MARK: - Actions
    @IBAction func cameraButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func noteButtonPressed(_ sender: UIButton) {
    }
    
    // MARK: - Methods
    
    // To receive the ModelControllers from the Main TabBar
    private func receiveDataFromTabBar() {
        guard let tabBar = tabBarController as? MainTabBarController else { return }
        
        self.controllers = tabBar.controllers
    }
    
    // Background Colors Setup
    private func setBGColors() {
        // Get BGColor
        guard let controllers = controllers,
            let color = controllers.themeController.currentColor else { return }
        
        // Set Colors
        setTabBarsBGColors(color: color)
        
        noteBGCardView.backgroundColor = color.bgCardColor
        cameraBGCardView.backgroundColor = color.bgCardColor
        
        takePictureLabel.textColor = color.fontColor
        createWithNotesLabel.textColor = color.fontColor
        
        // Round Corners
        noteBGCardView.layer.cornerRadius = 15
        cameraBGCardView.layer.cornerRadius = 15

        // Set Buttons Images
        cameraButton.setBackgroundImage(color.cameraImage, for: .normal)
        noteButton.setBackgroundImage(color.docImage, for: .normal)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Segue to CameraVC
        if segue.identifier == "ShowCameraVCSegue" {
            guard let cameraVC = segue.destination as? CameraViewController else { return }
            
            cameraVC.controllers = controllers
            cameraVC.cameraController = cameraController
        }
        
        // Segue to NewReminderDetailVC
        else if segue.identifier == "ShowNewReminderDetailVCSegue" {
            guard let newReminderDetailVC = segue.destination as? NewReminderDetailViewController else { return }
            
            newReminderDetailVC.controllers = self.controllers
            newReminderDetailVC.cameraController = cameraController
        }
    }
}
