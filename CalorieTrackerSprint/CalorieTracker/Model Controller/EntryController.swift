//
//  EntryController.swift
//  CalorieTracker
//
//  Created by Alex Rhodes on 10/17/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation
import SwiftChart

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
    
    func deleteEntry() {
        
    }
    
    func fetchEntry() {
        
    }
}
