//
//  ReminderController.swift
//  Remage
//
//  Created by macbook on 7/27/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import Foundation
import UserNotifications

class ReminderController {
    
    // MARK: - Properties
    
    var cdModelController = CoreDataModelController()
    var center = UNUserNotificationCenter.current()
    var notificationCounter = 0
    var permissionGranted: Bool?
    
    // MARK: - Methods
    
    // Save a New Reminder in CD WITH a alarm
    func saveNewReminderWith(alarmDate: Date, title: String? = nil, defaultImage: Data? = nil, note: String? = nil) {
        
        //requestPermission()
        
        // Create new Reminder
        let reminder = Reminder(context: CoreDataStack.shared.mainContext)
        
        // Add Properties available
        reminder.title = title
        reminder.note = note
        reminder.defaultImage = defaultImage
        reminder.alarmDate = alarmDate
        reminder.alarmOn = true
        
        // TODO: - Save the other images
        
        // Save reminder in Core Data
        CoreDataStack.shared.save(context: CoreDataStack.shared.mainContext)
        
        setNotification(title: title, note: note, date: alarmDate)
    }
    
    // Save a New Reminder in CD WITHOUT a alarm
    func saveNewReminder(title: String? = nil, defaultImage: Data? = nil, note: String? = nil) {
        
        // Create new Reminder
        let reminder = Reminder(context: CoreDataStack.shared.mainContext)
        
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
    
    // Request Permission to send Local Notifications
    func requestPermission() {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            self.permissionGranted = granted
            
            if let error = error {
                NSLog("Error requesting Permission for Notifications: \(error)")
            }
        }
    }
    
    // Set up a Local Notification for a Reminder
    private func setNotification(title: String?, note: String?, date: Date) {
        
        // Content
        let content = UNMutableNotificationContent()
        content.title = title ?? "Reminder Alert!"
        content.body = note ?? ""
        content.sound = .default
        
        // Counter of how many notifications so far
        notificationCounter += 1
        let counter = NSNumber(integerLiteral: notificationCounter)
        content.badge = counter
        
        // Trigger
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // Notification Request
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // Adding the Notification to the Center
        center.add(request) { (error) in
            if let error = error {
                NSLog("Error adding the Notification to the Notification Center: \(error)")
            }
        }
    }
}
