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
    
    var themeController: ThemeController?
    var reminderController: ReminderController?
    
    let cameraController = CameraController()  // TODO: - Should initiate at initial screen, and pass to this VC
    
    // MARK: - Outlets
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var noteButton: UIButton!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        receiveDataFromTabBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setBGColors()
    }
    
    // MARK: - Actions
    @IBAction func cameraButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func noteButtonPressed(_ sender: UIButton) {
    }
    
    // MARK: - Methods
    
    // To receive the ThemeController and ReminderController from the Main TabBar
    private func receiveDataFromTabBar() {
        guard let tabBar = tabBarController as? MainTabBarController else { return }
        
        self.themeController = tabBar.themeController
        self.reminderController = tabBar.reminderController
    }
    
    // Background Colors Setup
    private func setBGColors() {
        
        // Get BGColor
        guard let themeController = themeController,
            let color = themeController.currentColor else { return }
        
        // Set Colors
        view.backgroundColor = color.bgColor
        
        // Set NavigationBar and TabBar Colors
        navigationController?.navigationBar.tintColor = color.fontColor
        navigationController?.navigationBar.barTintColor = color.bgColor.withAlphaComponent(0.5)
        
        tabBarController?.tabBar.barTintColor = color.bgColor.withAlphaComponent(0.5)
        tabBarController?.tabBar.tintColor = color.fontColor
        tabBarController?.tabBar.unselectedItemTintColor = color.fontColor.withAlphaComponent(0.3)
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
            newReminderDetailVC.themeController = themeController
        }
    }
}
