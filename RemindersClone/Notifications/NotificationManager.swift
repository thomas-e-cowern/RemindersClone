//
//  NotificationManager.swift
//  RemindersClone
//
//  Created by Thomas Cowern on 1/15/24.
//

import Foundation
import UserNotifications

class NotificationManager {
    static func scheduleNotification(userData: UserData) {
        
        let content = UNMutableNotificationContent()
        content.title = userData.title ?? ""
        content.body = userData.body ?? "" // Reminder notes
        
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: userData.date ?? Date())
        
        if let reminderTime = userData.time {
            let reminderTimeDateComponents = reminderTime.dateComponents
            dateComponents.hour = reminderTimeDateComponents.hour
            dateComponents.minute = reminderTimeDateComponents.minute
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "Reminder Notification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
