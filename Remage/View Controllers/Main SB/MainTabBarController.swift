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
    
    var controllers = ModelControllers()
    var user: User?
    
    // MARK: - DidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        controllers.setupControllers()
        setUser()
    }
    
    // MARK: - Methods
    
    // Setup for this User
    private func setUser() {
        user = controllers.userController.getUser()
        
        // Setup
        getTheme()
    }
    
    // Get Theme from ThemeController
    private func getTheme() {
        
        if let user = user,
            let represenation = user.userRepresentation {
            
            if let color = represenation.bgColor {
                // Setup the BGColor if the User has choosen one before
                
                controllers.themeController.userBGColor = color
                controllers.themeController.setCurrentColor()
                
            } else {
                // Setup the default BGColor if the User doesn't have a BGColor set yet
                controllers.themeController.setCurrentColor()
            }
        }
    }
}
