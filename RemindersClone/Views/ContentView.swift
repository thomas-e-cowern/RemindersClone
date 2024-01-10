//
//  ContentView.swift
//  RemindersClone
//
//  Created by Thomas Cowern on 1/10/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Something or other")
                
                Spacer()
                
                Button {
                    isPresented = true
                } label: {
                    Text("Add List")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.headline)
                }
                .padding()
            }
            .sheet(isPresented: $isPresented, content: {
                NavigationView {
                    AddNewListVIew { name, color in
                        // save to core data
                        do {
                            try ReminderService.saveMyList(name, color)
                        } catch {
                            print("Error trying to save list in ContentIview: \(error.localizedDescription)")
                        }
                        
                    }
                }
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
