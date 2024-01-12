//
//  ReminderListView.swift
//  RemindersClone
//
//  Created by Thomas Cowern on 1/11/24.
//

import SwiftUI

struct ReminderListView: View {
    
    @State private var selectedReminder: Reminder?
    @State private var showReminderDetail: Bool = false
    let reminders: FetchedResults<Reminder>
    
    var body: some View {
        VStack {
            List(reminders) { reminder in
                ReminderCellView(reminder: reminder, isSelected: isReminderSelected(reminder)) { event in
                    switch event {
                    case .onSelect(let reminder):
                        print("On Selected")
                        selectedReminder = reminder
                    case .onCheckChanged(let reminder, let isCompleted):
                        print("On Checked")
                        reminderCheckChanged(reminder: reminder, isCompleted: isCompleted)
                    case .onInfo:
                        print("On Info")
                        showReminderDetail = true
                    }
                }
            }
        }
        .sheet(isPresented: $showReminderDetail, content: {
            ReminderDetailView(reminder: Binding($selectedReminder)!)
        })
    }
    
    private func reminderCheckChanged(reminder: Reminder, isCompleted: Bool) {
        var editConfig = ReminderEditConfig(reminder: reminder)
        editConfig.isCompleted = isCompleted
        
        do {
            let _ = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch {
            print("Error in reminderCheckChanged: \(error.localizedDescription)")
        }
    }
    
    private func isReminderSelected(_ reminder: Reminder) -> Bool {
        selectedReminder?.objectID == reminder.objectID
    }
}

//#Preview {
//    ReminderListView()
//}
