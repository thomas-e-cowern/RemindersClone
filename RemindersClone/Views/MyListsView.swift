//
//  MyListsView.swift
//  RemindersClone
//
//  Created by Thomas Cowern on 1/10/24.
//

import SwiftUI

struct MyListsView: View {
    
    let myLists: FetchedResults<MyList>
    
    var body: some View {
        NavigationStack {
            if myLists.isEmpty {
                Spacer()
                Text("No Reminders List Found")
            } else {
                List {
                    ForEach(myLists) { list in
                        Text(list.name)
                    }
                }
            }
        }
    }
}

//#Preview {
//    MyListsView()
//}
