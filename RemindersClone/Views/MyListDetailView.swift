//
//  MyListDetailView.swift
//  RemindersClone
//
//  Created by Thomas Cowern on 1/11/24.
//

import SwiftUI

struct MyListDetailView: View {
    
    let myList: MyList
    @State private var openAddReminder: Bool = false
    @State private var title: String = ""
    
    @FetchRequest(sortDescriptors: [])
    private var reminderResults: FetchedResults<Reminder>
    
    private var isFormValid: Bool {
        !title.isEmpty
    }
    
    init(myList: MyList) {
        self.myList = myList
        _reminderResults = FetchRequest(fetchRequest: ReminderService.getRemindersByList(myList: myList))
    }
    
    var body: some View {
        VStack {
            
            // List of reminders
            ReminderListView(reminders: reminderResults)
            
            HStack {
                Image(systemName: "plus.circle.fill")
                Button("New Reminder") {
                    openAddReminder = true
                }
            }
            .foregroundStyle(.blue)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .sheet(isPresented: $openAddReminder, content: {
            AddReminderTitleView(myList: myList)
                .presentationDetents([.height(200)])
        })
//        .alert("New Reminder", isPresented: $openAddReminder) {
//            TextField("", text: $title)
//            Button("Cancel", role: .cancel) {
//                // cancel entry
//            }
//            Button("Save") {
//                do {
//                    try ReminderService.saveReminderToMyList(myList: myList, reminderTitle: title)
//                } catch {
//                    print("Problem save reminder in MyListDetailView: \(error.localizedDescription)")
//                }
//            }
//            .disabled(!isFormValid)
//        }
    }
}

#Preview {
    MyListDetailView(myList: PreviewData.myList)
}
