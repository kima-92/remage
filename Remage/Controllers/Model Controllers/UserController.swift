//
//  UserController.swift
//  Remage
//
//  Created by macbook on 8/31/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import Foundation

class UserController {
    
    // MARK: - Properties
    var cdController: CoreDataModelController?
    
    // MARK: - Methods
    
    // Try to get the Main User
    func getUser() -> User? {
        guard let cdController = cdController else { return nil }
        
        if let user = cdController.fetchUserFromCoreData() {
            return user
        }
        return createUser()
    }
    
    // Create a New User
    private func createUser() -> User {
        
        let moc = CoreDataStack.shared.mainContext
        let user = User(id: UUID().uuidString, context: moc)
        
        // Save User in Core Data
        CoreDataStack.shared.save(context: moc)
        
        return user
    }
    
    // Setting the BGColor preference of the User
    func setBGColorFor(user: User, color: BGColor) {
        user.bgColorString = color.name
        
        // Save Change in Core Data
        CoreDataStack.shared.save(context: CoreDataStack.shared.mainContext)
    }
}
