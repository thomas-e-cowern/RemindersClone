//
//  ReminderDetailView.swift
//  RemindersClone
//
//  Created by Thomas Cowern on 1/11/24.
//

import SwiftUI

struct ReminderDetailView: View {
    
    @Binding var reminder: Reminder
    
    @State var editConfig: ReminderEditConfig = ReminderEditConfig()
    
    var body: some View {
        NavigationView(content: {
            VStack {
                List {
                    Section {
                        TextField("Title", text: $editConfig.title)
                        TextField("Notes", text: $editConfig.notes)
                    }
                }
            }
            .onAppear {
                editConfig = ReminderEditConfig(reminder: reminder)
            }
        })
    }
}

#Preview {
    ReminderDetailView(reminder: .constant(PreviewData.reminder))
}
