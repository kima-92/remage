//
//  User+Conveniece.swift
//  Remage
//
//  Created by macbook on 7/29/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import Foundation
import CoreData

extension User {
    
    // ReminderRepresentation for encoding/decoding purposes
    var userRepresentation: UserRepresentation? {
        guard let id = id else { return nil }
        
        let color = self.bgColorString
        let list = ColorList()
        let colors = list.bgColors
        let bgColors = colors.filter({$0.name == color})
        
        let bgColor = bgColors[0]
        
        return UserRepresentation(bgColor: bgColor, id: id)
    }
    
    @discardableResult convenience init(id: String, context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.id = id
    }
}
