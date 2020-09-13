//
//  ModelController.swift
//  Remage
//
//  Created by macbook on 9/1/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import Foundation

class ModelControllers {
    
    // MARK: - Properties
    
    var cdController = CoreDataModelController()
    var reminderController = ReminderController()
    var userController = UserController()
    
    var themeController = ThemeController()
    
    // MARK: - Methods
    
    // Setting up the CDController for the rest of the Controllers
    func setupControllers() {
        reminderController.cdModelController = cdController
        userController.cdController = reminderController.cdModelController
        reminderController.requestPermission()
    }
}
