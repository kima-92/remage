//
//  Reminder+Convenience.swift
//  Remage
//
//  Created by macbook on 4/23/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import Foundation
import CoreData

extension Reminder {
    
    // ReminderRepresentation for encoding/decoding purposes
    var reminderRepresentation: ReminderRepresentation? {
        guard let id = id,
        let alarmID = alarmID else { return nil }
        
        return ReminderRepresentation(id: id, alarmID: alarmID)
    }
    
    @discardableResult convenience init(id: String, context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.id = id
    }
    
    // TODO: - Make an init from the ReminderRepresentation
}
