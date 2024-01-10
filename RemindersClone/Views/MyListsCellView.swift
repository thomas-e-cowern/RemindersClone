//
//  MyListsCellView.swift
//  RemindersClone
//
//  Created by Thomas Cowern on 1/10/24.
//

import SwiftUI

struct MyListsCellView: View {
    
    let myList: MyList
    
    var body: some View {
        HStack {
            Image(systemName: "line.3.horizontal.circle.fill")
                .foregroundStyle(Color(myList.color))
                .padding(.leading, 10)
            Text(myList.name)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.gray)
                .opacity(0.4)
                .padding(.trailing, 10)
            
        }
    }
}

#Preview {
    MyListsCellView(myList: PreviewData.myList)
}
