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
    func saveNewReminderWith(alarmDate: Date, defaultImage: Data? = nil, note: String? = nil) {
        
        // Create new Reminder
        let reminder = Reminder(context: CoreDataStack.shared.mainContext)
        
        // Add Properties available
        reminder.note = note
        reminder.defaultImage = defaultImage
        
        reminder.alarmDate = alarmDate
        reminder.alarmOn = true
        reminder.alarmID = setNotification(note: note, date: alarmDate)
        
        // TODO: - Save the other images
        
        // Save reminder in Core Data
        CoreDataStack.shared.save(context: CoreDataStack.shared.mainContext)
    }
    
    // Save a New Reminder in CD WITHOUT a alarm
    func saveNewReminder(defaultImage: Data? = nil, note: String? = nil) {
        
        // Create new Reminder
        let reminder = Reminder(context: CoreDataStack.shared.mainContext)
        
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
        CoreDataStack.shared.save(context: CoreDataStack.shared.mainContext)
    }
    
    func turnAlarmOnFor(reminder: Reminder) {
        reminder.alarmOn = true
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
    private func setNotification(note: String?, date: Date) -> String {
        
        // Content
        let content = UNMutableNotificationContent()
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
        let alarmID = UUID().uuidString
        let request = UNNotificationRequest(identifier: alarmID, content: content, trigger: trigger)
        
        // Adding the Notification to the Center
        center.add(request) { (error) in
            if let error = error {
                NSLog("Error adding the Notification to the Notification Center: \(error)")
            }
        }
        return alarmID
    }
    
    // Set up a Local Notification for a Reminder
    private func updateNotification(alarmID: String, title: String, note: String, date: Date) {
        
        // Content
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = note
        content.sound = .default
        
        // Counter of how many notifications so far
        notificationCounter += 1
        let counter = NSNumber(integerLiteral: notificationCounter)
        content.badge = counter
        
        // Trigger
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // Notification Request with previous alarmID
        let request = UNNotificationRequest(identifier: alarmID, content: content, trigger: trigger)
        
        // Adding the Notification to the Center
        center.add(request) { (error) in
            if let error = error {
                NSLog("Error updating the Notification in the Notification Center: \(error)")
            }
        }
    }
    
    // Turn Off all delivered Notifications
    // and delete them from the NotificationCenter
    func turnOffAllDeliveredNotifications() {
        var requestIDs: [String] = []
        
        center.getDeliveredNotifications { (deliveredNotifications) in
            requestIDs = deliveredNotifications.compactMap({ $0.request.identifier })
        
            if requestIDs.count > 0 {
                
                let fetchSuccessful = self.cdModelController.turnOffDeliveredReminders(alarmIDs: requestIDs)
            
                // Delete if the fetch was successful
                if fetchSuccessful {
                    self.center.removeAllDeliveredNotifications()
                }
            }
        }
    }
}
