//
//  AddNewListVIew.swift
//  RemindersClone
//
//  Created by Thomas Cowern on 1/10/24.
//

import SwiftUI

struct AddNewListVIew: View {
    
    @State private var name: String = ""
    
    var body: some View {
        VStack {
            VStack {
                Image(systemName: "line.3.horizontal.circle.fill")
                    .foregroundStyle(.blue)
                    .font(.system(size: 100))
                TextField("List Name", text: $name)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(30)
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            
            Spacer()
        }
    }
}

#Preview {
    AddNewListVIew()
}
