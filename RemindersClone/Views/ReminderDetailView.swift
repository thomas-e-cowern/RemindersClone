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
                        dismiss()
                    }
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
