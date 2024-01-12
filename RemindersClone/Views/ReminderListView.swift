//
//  ReminderListView.swift
//  RemindersClone
//
//  Created by Thomas Cowern on 1/11/24.
//

import SwiftUI

struct ReminderListView: View {
    
    let reminders: FetchedResults<Reminder>
    
    var body: some View {
        List(reminders) { reminder in
            ReminderCellView(reminder: reminder) { event in
                switch event {
                case .onSelect(let reminder):
                    print("On Selected")
                case .onCheckChanged(let reminder):
                    print("On Checked")
                    reminderCheckChanged(reminder: reminder)
                case .onInfo:
                    print("On Info")
                }
            }
        }
    }
    
    private func reminderCheckChanged(reminder: Reminder) {
        var editConfig = ReminderEditConfig(reminder: reminder)
        editConfig.isCompleted.toggle()
        
        do {
            let _ = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch {
            print("Error in reminderCheckChanged: \(error.localizedDescription)")
        }
    }
}

//#Preview {
//    ReminderListView()
//}
