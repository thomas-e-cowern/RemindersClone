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
            Text(reminder.title ?? "")
        }
    }
}

//#Preview {
//    ReminderListView()
//}
