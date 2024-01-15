//
//  ReminderDetailView.swift
//  RemindersClone
//
//  Created by Thomas Cowern on 1/11/24.
//

import SwiftUI

struct ReminderDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var reminder: Reminder
    
    @State var editConfig: ReminderEditConfig = ReminderEditConfig()
    
    private var isFormValid: Bool {
        !editConfig.title.isEmpty
    }
    
    var body: some View {
        NavigationView(content: {
            VStack {
                List {
                    Section {
                        TextField("Title", text: $editConfig.title)
                        TextField("Notes", text: $editConfig.notes ?? "")
                    }
                    
                    Section {
                        Toggle(isOn: $editConfig.hasDate, label: {
                            Image(systemName: "calendar")
                                .foregroundStyle(.red)
                        })
                        
                        if editConfig.hasDate {
                            DatePicker("Select Date", selection: $editConfig.reminderDate ?? Date(), displayedComponents: .date)
                        }
                        
                        Toggle(isOn: $editConfig.hasTime, label: {
                            Image(systemName: "clock")
                                .foregroundStyle(.blue)
                        })
                        
                        if editConfig.hasTime {
                            DatePicker("Select Time", selection: $editConfig.reminderTime ?? Date(), displayedComponents: .hourAndMinute)
                        }
                    }
                    
                    Section {
                        NavigationLink {
                            SelectListView(selectList: $reminder.list)
                        } label: {
                            HStack {
                                Text("List")
                                Spacer()
                                Text(reminder.list?.name ?? "")
                            }
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
            .onAppear {
                editConfig = ReminderEditConfig(reminder: reminder)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Details")
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        // save then dismiss
                        do {
                            print("editConfig: \(editConfig)")
                            let updated = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
                            if updated {
                                // check to schedule
                                if reminder.reminderDate != nil || reminder.reminderTime != nil {
                                    let userData = UserData(title: reminder.title, body: reminder.notes, date: reminder.reminderDate, time: reminder.reminderTime)
                                    
                                    NotificationManager.scheduleNotification(userData: userData)
                                }
                            }
                        } catch {
                            print("Failed to update in reminder detail view: \(error.localizedDescription)")
                        }
                        
                        dismiss()
                    }
                    .disabled(!isFormValid)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        })
    }
}

#Preview {
    ReminderDetailView(reminder: .constant(PreviewData.reminder))
}
