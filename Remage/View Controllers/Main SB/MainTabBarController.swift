//
//  MainTabBarController.swift
//  Remage
//
//  Created by macbook on 7/29/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Properties
    
    var themeController = ThemeController()
    var reminderController = ReminderController()
    var userController = UserController()
    
    var user: User?
    
    // MARK: - DidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        setUser()
    }
    
    // MARK: - Methods
    
    // Setup for this User
    private func setUser() {
        
        // Set userController's cdController
        userController.cdController = reminderController.cdModelController
        // Get the User
        user = userController.getUser()
        
        // Setup
        getTheme()
    }
    
    // Get Theme from ThemeController
    private func getTheme() {
        
        if let user = user,
            let represenation = user.userRepresentation {
            
            if let color = represenation.bgColor {
                // Setup the BGColor if the User has choosen one before
                
                themeController.userBGColor = color
                themeController.setCurrentColor()
                
            } else {
                // Setup the default BGColor if the User doesn't have a BGColor set yet
                themeController.setCurrentColor()
            }
        }
    }
}
