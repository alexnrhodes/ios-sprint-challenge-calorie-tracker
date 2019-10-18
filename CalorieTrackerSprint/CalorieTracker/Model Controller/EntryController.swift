//
//  EntryController.swift
//  CalorieTracker
//
//  Created by Alex Rhodes on 10/17/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation

class EntryController {
    
    
    // MARK: CRUD
    
    func createEntry(with calories: Double) {
        
        let entry = Entry(calories: calories)
        CoreDataStack.shared.save()
    }
    
    func updateEntry() {
        
    }
    
    func deleteEntry() {
        
    }
    
    func fetchEntry() {
        
    }
}
