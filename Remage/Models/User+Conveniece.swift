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
    
    // UserRepresentation for encoding/decoding purposes
    var userRepresentation: UserRepresentation? {
        
        guard let id = id else { return nil }
        let color = getColor()
        
        return UserRepresentation(bgColor: color, id: id)
    }
    
    @discardableResult convenience init(id: String, context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.id = id
    }
    
    // Convert bgColorString to a BGColor for the UserRepresentation
    private func getColor() -> BGColor? {
        if let colorString = bgColorString {
            
            let list = ColorList()
            let colors = list.bgColors
            let filteredColors = colors.filter({ $0.name == colorString })
            let color = filteredColors[0]
            
            return color
        }
        return nil
    }
}
