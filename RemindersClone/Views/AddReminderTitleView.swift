//
//  AddReminderTitleView.swift
//  RemindersClone
//
//  Created by Thomas Cowern on 1/11/24.
//

import SwiftUI

struct AddReminderTitleView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    
    let myList: MyList
    
    private var isFormValid: Bool {
        !title.isEmpty
    }
    var body: some View {
        VStack {
            TextField("", text: $title)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
            HStack(spacing: 12) {
                Button("Cancel", role: .cancel) {
                    // cancel entry
                    dismiss()
                }
                Button("Save") {
                    do {
                        try ReminderService.saveReminderToMyList(myList: myList, reminderTitle: title)
                    } catch {
                        print("Problem save reminder in AddReminderTitleView: \(error.localizedDescription)")
                    }
                    dismiss()
                }
                .disabled(!isFormValid)
            }
        }
        .padding()
    }
}

#Preview {
    AddReminderTitleView(myList: PreviewData.myList)
}
