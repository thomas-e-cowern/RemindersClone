//
//  ReminderDetailView.swift
//  RemindersClone
//
//  Created by Thomas Cowern on 1/11/24.
//

import SwiftUI

struct ReminderDetailView: View {
    
    @Binding var reminder: Reminder
    
    var body: some View {
        NavigationView(content: {
            VStack {
                List {
                    Section {
                        Text("Title", text: )
                    }
                }
            }
        })
    }
}

#Preview {
    ReminderDetailView(reminder: .constant(PreviewData.reminder))
}
