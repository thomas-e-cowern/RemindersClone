//
//  ReminderCellView.swift
//  RemindersClone
//
//  Created by Thomas Cowern on 1/11/24.
//

import SwiftUI

struct ReminderCellView: View {
    
    let reminder: Reminder
    
    var body: some View {
        HStack {
            
            Image(systemName: "circle")
                .font(.title)
                .opacity(0.4)
            
            VStack {
                Text(reminder.title ?? "")
                if let notes = reminder.notes, notes.isEmpty {
                    Text(notes)
                        .font(.caption)
                        .opacity(0.4)
                }
            }
            
            HStack {
                if let date = reminder.reminderDate {
                    Text(formatDate(date))
                }
                
                if let time = reminder.reminderTime {
                    Text(time.formatted(date: .omitted, time: .shortened))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.caption)
            .opacity(0.4)
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        if date.isToday {
            return "Today"
        } else if date.isTomorrow {
            return "Tomorrow"
        } else {
            return date.formatted(date: .numeric, time: .omitted)
        }
    }
}

#Preview {
    ReminderCellView(reminder: PreviewData.reminder)
}
