//
//  ReminderRepresentation.swift
//  Remage
//
//  Created by macbook on 4/23/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import Foundation

struct ReminderRepresentation: Codable {
    
    var id: String
    var title: String?
    var note: String?
    var priority: String?
    
    var defaultImage: Data?
    // TODO: - The default image shouldn't be optional
    // Either save a default image or make a thumbnail out of the note or title and use that as the default image
    
    var image1: Data?
    var image2: Data?
    var image3: Data?
    var image4: Data?
    var image5: Data?
    
    var dayCreated: Date?
    var dueDate: Date?
    
    init(id: String) {
        
        self.id = id
    }
    
    // TODO: - Might need an init fro decoder
}
