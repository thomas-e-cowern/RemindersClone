//
//  CoreDataProvider.swift
//  RemindersClone
//
//  Created by Thomas Cowern on 1/10/24.
//

import Foundation
import CoreData

class CoreDataProvider {
    
    static let shared = CoreDataProvider()
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "RemindersModel")
        persistentContainer.loadPersistentStores { descrtiption, error in
            if let error {
                fatalError("Error initializing Reminders Model: \(error.localizedDescription)")
            }
        }
    }
}
