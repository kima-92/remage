//
//  CoreDataStack.swift
//  Remage
//
//  Created by Wilma on 4/27/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {

    static let shared = CoreDataStack()

    // Persistent Container
    lazy var container: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Remage")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }

        // MARK: Automatically merging changes from parent
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()

    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }

    func save(context: NSManagedObjectContext) {
        context.performAndWait {
            do {
                try context.save()
            } catch {
                NSLog("Error saving context: \(error)")
                context.reset()
            }
        }
    }
}
