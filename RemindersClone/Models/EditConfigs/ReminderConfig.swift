//
//  ReminderConfig.swift
//  RemindersClone
//
//  Created by Thomas Cowern on 1/11/24.
//

import Foundation

struct ReminderEditConfig {
    var title: String = ""
    var notes: String?
    var isCompleted: Bool = false
    var hasDate: Bool = false
    var hasTime: Bool = false
    var reminderDate: Date?
    var reminderTime: Date?
    
    init() {
        
    }
    
    init(reminder: Reminder) {
        title = reminder.title ?? ""
        notes = reminder.notes
        isCompleted = reminder.isCompleted
        reminderDate = reminder.reminderDate ?? Date.now
        reminderTime = reminder.reminderTime ?? Date.now
        hasDate = reminder.reminderDate != nil
        hasTime = reminder.reminderTime != nil
    }
}



