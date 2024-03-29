//
//  MyList+CoreDataClass.swift
//  RemindersClone
//
//  Created by Thomas Cowern on 1/10/24.
//

import Foundation
import CoreData

@objc(MyList)
public class MyList: NSManagedObject {
    var remindersArray: [Reminder] {
        reminders?.allObjects.compactMap { ($0 as! Reminder) } ?? []
    }
}
