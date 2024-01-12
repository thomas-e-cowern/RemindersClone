//
//  SelectListView.swift
//  RemindersClone
//
//  Created by Thomas Cowern on 1/12/24.
//

import SwiftUI

struct SelectListView: View {
    
    @Binding var selectList: MyList?
    
    @FetchRequest(sortDescriptors: [])
    private var myListsFetchResults: FetchedResults<MyList>
    
    
    var body: some View {
        List(myListsFetchResults) { list in
            HStack {
                HStack {
                    Image(systemName: "line.3.horizontal.circle.fill")
                        .foregroundStyle(Color(list.color))
                    Text(list.name)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    self.selectList = list
                }
                
                if selectList == list {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

#Preview {
    SelectListView(selectList: .constant(PreviewData.myList))
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
