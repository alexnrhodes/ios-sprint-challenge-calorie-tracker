//
//  CoreDataStack.swift
//  CalorieTracker
//
//  Created by Alex Rhodes on 10/17/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    private init() { }
    
    // lazy doesn't initialize upone class initialization, it is only called when needed
    lazy var container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Entry")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                fatalError("Core sata was unable to load persistence stores: \(error)")
            }
        })
        
        return container
    }()
    
    var backgroundContext: NSManagedObjectContext {
        return container.newBackgroundContext()
    }
    
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    func save() {
        
        let context = CoreDataStack.shared.mainContext
        
        context.performAndWait {
            do {
                try context.save()
            } catch {
                NSLog("error saving context: \(error)")
                context.reset()
            }
        }
    }
}
