//
//  ReminderCellView.swift
//  RemindersClone
//
//  Created by Thomas Cowern on 1/11/24.
//

import SwiftUI

enum ReminderCellEvents {
    case onInfo
    case onCheckChanged(Reminder, Bool)
    case onSelect(Reminder)
}

struct ReminderCellView: View {
    
    @State private var checked: Bool = false
    
    let reminder: Reminder
    let delay = Delay()
    let isSelected: Bool
    
    let onEvent: (ReminderCellEvents) -> Void
    
    var body: some View {
        HStack {
            
            Image(systemName: checked ? "circle.inset.filled" : "circle")
                .font(.title)
                .opacity(0.4)
                .onTapGesture {
                    checked.toggle()
                    
                    //  cancel old task
                    delay.cancel()
                    
                    // call delay
                    delay.performWork {
                        onEvent(.onCheckChanged(reminder, checked))
                    }
                }
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text(reminder.title ?? "")
                    if let notes = reminder.notes, !notes.isEmpty {
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

            
            Spacer()
            
            Image(systemName: "info.circle.fill")
                .opacity(isSelected ? 1.0 : 0)
                .onTapGesture {
                    onEvent(.onInfo)
                }
        }
        .onAppear {
            checked = reminder.isCompleted
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onEvent(.onSelect(reminder))
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
    ReminderCellView(reminder: PreviewData.reminder, isSelected: false, onEvent: { _ in })
}
