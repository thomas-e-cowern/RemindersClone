//
//  StatsBuilder.swift
//  RemindersClone
//
//  Created by Thomas Cowern on 1/15/24.
//

import Foundation
import SwiftUI

struct ReminderStatsValues {
    var todayCount: Int = 0
    var scheduledCount: Int = 0
    var allCount: Int = 0
    var completedCount: Int = 0
}

struct StatsBuilder {
    
    func build(myListResults: FetchedResults<MyList>) -> ReminderStatsValues {
        
        let remindersArray = myListResults.map { $0.remindersArray }.reduce([], +)
        
        let allCount = calculateAllCount(reminders: remindersArray)
        let completedCount = calculateCompletedCount(reminders: remindersArray)
        let todayCount = calculateTodayCount(reminders: remindersArray)
        let scheduledCount = calculateScheduledCount(reminders: remindersArray)
        
        return ReminderStatsValues(todayCount: todayCount, scheduledCount: scheduledCount, allCount: allCount, completedCount: completedCount)
    }
    
    private func calculateAllCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return !reminder.isCompleted ? result + 1 : result
        }
    }
    
    private func calculateCompletedCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return reminder.isCompleted ? result + 1 : result
        }
    }
    
    private func calculateTodayCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            let isToday = reminder.reminderDate?.isToday ?? false
            return isToday ? result + 1 : result
        }
    }
    
    private func calculateScheduledCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            let isScheduled = (reminder.reminderDate != nil || reminder.reminderTime != nil) && !reminder.isCompleted
            return isScheduled ? result + 1 : result
        }
    }
}
