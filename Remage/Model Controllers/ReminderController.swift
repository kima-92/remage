//
//  ReminderController.swift
//  Remage
//
//  Created by macbook on 7/27/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import Foundation

class ReminderController {
    
    var cdModelController = CoreDataModelController()
    
    // Save a New Reminder in CD
    func saveNewReminder(title: String? = nil, defaultImage: Data? = nil, note: String? = nil, alarmDate: Date? = nil) {
        
//        // Create new Reminder
//        let reminder = Reminder(id: UUID().uuidString, context: CoreDataStack.shared.mainContext)
        let reminder = Reminder(context: CoreDataStack.shared.mainContext)
        
        // Add Properties available
        reminder.title = title
        reminder.note = note
        reminder.defaultImage = defaultImage
        
        // TODO: - Save the other images
        
        // Save reminder in Core Data
        CoreDataStack.shared.save(context: CoreDataStack.shared.mainContext)
    }
    
    // Add images to a Reminder
    func addImagesTo(reminder: Reminder, image1: Data? = nil, image2: Data? = nil, image3: Data? = nil, image4: Data? = nil, image5: Data? = nil) {
        
        reminder.image1 = image1
        reminder.image2 = image2
        reminder.image3 = image3
        reminder.image4 = image4
        reminder.image5 = image5
        
        // Save reminder in Core Data
        CoreDataStack.shared.save(context: CoreDataStack.shared.mainContext)
    }
    
    func setAlarmFor(reminder: Reminder, date: Date) {
        reminder.alarmOn = true
        reminder.alarmDate = date
        
        // Save change in CoreData
        CoreDataStack.shared.save(context: CoreDataStack.shared.mainContext)
    }
    
    func turnAlarmOffFor(reminder: Reminder) {
        reminder.alarmOn = false
        
        // Save change in CoreData
        CoreDataStack.shared.save(context: CoreDataStack.shared.mainContext)
    }
}
