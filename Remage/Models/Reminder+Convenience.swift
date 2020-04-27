//
//  Reminder+Convenience.swift
//  Remage
//
//  Created by macbook on 4/23/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import Foundation

extension Reminder {
    
    // ReminderRepresentation for encoding/decoding purposes
    var reminderRepresentation: ReminderRepresentation? {
        guard let id = id else { return nil }
        
        return ReminderRepresentation(id: id)
    }
    
    @discardableResult convenience init(id: String) {
        self.id = id
    }
    
}
