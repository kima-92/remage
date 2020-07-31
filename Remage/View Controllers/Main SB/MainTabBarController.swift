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
    
    // MARK: - DidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        getTheme()
    }
    
    // MARK: - Methods
    
    // Get Theme from ThemeController
    private func getTheme() {
        // Get main user
        let user = reminderController.cdModelController.fetchMainUserFromCoreData()
        
        // Get the User's Color Preference
        if user != nil {
            themeController.userBGColor = user?.userRepresentation?.bgColor
            themeController.setCurrentColor()
        } else {
            themeController.setCurrentColor()
        }
    }
}
