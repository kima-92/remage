//
//  CoreDataModelController.swift
//  Remage
//
//  Created by macbook on 4/27/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import Foundation
import CoreData

class CoreDataModelController {
    
    // MARK: - Properties
    var reminder: Reminder?
    var user: User?
    
    // MARK: - Fetching from CoreData Methods
    
    // Fetch for one Reminder by id
    func fetchReminderFromCoreData(id: String) -> Reminder? {
        
        let moc = CoreDataStack.shared.mainContext
        
        // Create a fetch request for fetching reminders
        let fetchRequest: NSFetchRequest<Reminder> = Reminder.fetchRequest()
        
        // An array of the IDs we need to fetch for
        let remindersByIDs = [id]
        
        // Add a predicate to the fetch request
        fetchRequest.predicate = NSPredicate(format: "id IN %@", remindersByIDs)
        
        // Try to fetch
        do {
            let reminders = try moc.fetch(fetchRequest)
            
            for reminder in reminders {
                
                if reminder.id == id {
                    self.reminder = reminder
                }
                else {
                    self.reminder = nil
                }
            }
        } catch {
            NSLog("Couldn't perform fetch for reminder")
            self.reminder = nil
        }
        return reminder
    }
    
    // Fetch multiple Reminders
    func fetchRemindersFromCoreData() -> [Reminder]? {
        let moc = CoreDataStack.shared.mainContext
        
        // Create a fetch request for fetching reminders
        let fetchRequest: NSFetchRequest<Reminder> = Reminder.fetchRequest()
        
        // Try to fetch
        do {
            let reminders = try moc.fetch(fetchRequest)
            return reminders
        } catch {
            NSLog("Couldn't perform fetch for reminders")
            return nil
        }
    }
    
    // Fetch the main user of this app
    func fetchUserFromCoreData() -> User? {
        
        let moc = CoreDataStack.shared.mainContext
        
        // Create a fetch request for fetching users
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        // Try to fetch
        do {
            let users = try moc.fetch(fetchRequest)
            
            // Save user if there is one
            if users.count >= 1 {
                self.user = users[0]
            }
        } catch {
            NSLog("Couldn't perform fetch for user")
            self.user = nil
        }
        return user
    }
}
