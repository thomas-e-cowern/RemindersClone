//
//  ReminderService.swift
//  RemindersClone
//
//  Created by Thomas Cowern on 1/10/24.
//

import Foundation
import CoreData
import UIKit

class ReminderService {
    
    static var viewContext: NSManagedObjectContext {
        CoreDataProvider.shared.persistentContainer.viewContext
    }
    
    static func saveMyList(_ name: String, _ color: UIColor) throws {
        let myList = MyList(context: viewContext)
        myList.name = name
        myList.color = color
        try save()
    }
    
    static func save() throws {
        try viewContext.save()
    }
    
}