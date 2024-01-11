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
        print("In saveMyList")
        let myList = MyList(context: viewContext)
        myList.name = name
        myList.color = color
        print("Saved list \(myList.name)")
        try save()
    }
    
    static func save() throws {
        
        do {
            try viewContext.save()
        } catch {
            print("Error in save func: \(error.localizedDescription)")
        }
        
    }
    
    static func saveReminderToMyList(myList: MyList, reminderTitle: String) throws {
        print("In saveReminderToMyList")
        let reminder = Reminder(context: viewContext)
        reminder.title = reminderTitle
        myList.addToReminders(reminder)
        print("Saved reminder to \(myList)")
        try save()
    }
    
    static func getRemindersByList(myList: MyList) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        request.predicate = NSPredicate(format: "list = %@ AND isCompleted = false", myList)
        print("Request: \(request)")
        return request
    }
}
