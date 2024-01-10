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
                ForEach(myLists) { list in
                    VStack {
                        MyListsCellView(myList: list)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title3)
                        Divider()
                    }
                }
            }
        }
    }
}

//#Preview {
//    MyListsView()
//}
