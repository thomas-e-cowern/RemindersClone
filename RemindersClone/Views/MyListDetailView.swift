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
    
    private var isFormValid: Bool {
        !title.isEmpty
    }
    
    var body: some View {
        VStack {
            
            // List of reminders
            
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
        .alert("New Reminder", isPresented: $openAddReminder) {
            TextField("", text: $title)
            Button("Cancel", role: .cancel) {
                // cancel entry
            }
            Button("Save") {
                
            }
            .disabled(!isFormValid)
        }
    }
}

#Preview {
    MyListDetailView(myList: PreviewData.myList)
}
