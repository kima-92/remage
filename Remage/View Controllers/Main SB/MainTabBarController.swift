//
//  MainTabBarController.swift
//  Remage
//
//  Created by macbook on 7/29/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    var themeController = ThemeController()
    var reminderController = ReminderController()

    override func viewDidLoad() {
        super.viewDidLoad()
        getTheme()
    }
    
    private func getTheme() {
        // Get main user
        let user = reminderController.cdModelController.fetchMainUserFromCoreData()
        
        // Get the User's Color Preference
        if user != nil {
            themeController.userBGColor = user?.userRepresentation?.bgColor
            themeController.setCurrentColor()
        }
    }
}
