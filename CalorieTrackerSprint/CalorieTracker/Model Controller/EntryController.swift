//
//  EntryController.swift
//  CalorieTracker
//
//  Created by Alex Rhodes on 10/17/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation
import SwiftChart
import CoreData

class EntryController {
    
    var entries = [Entry]()
    
    var series = [Double]()
    
    // MARK: CRUD
    
    func createEntry(with calories: Double) {
        
        let entry = Entry(calories: calories)
        CoreDataStack.shared.save()
        
        entries.append(entry)
        
        let mapResult = entries.map { value in
            value.calories
        }
        self.series = mapResult
    }
    
    func updateEntry() {
        
    }
    
    func delete(entry: Entry) {
        let context = CoreDataStack.shared.mainContext
        
        context.performAndWait {
            
            context.delete(entry)
            CoreDataStack.shared.save()
            
        }
    }
    
    func fetchEntry() {
        
    }
}
