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
                case .onInfo:
                    print("On Info")
                }
            }
        }
    }
}

//#Preview {
//    ReminderListView()
//}
