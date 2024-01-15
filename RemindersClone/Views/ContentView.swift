//
//  ContentView.swift
//  RemindersClone
//
//  Created by Thomas Cowern on 1/10/24.
//

import SwiftUI

struct ContentView: View {
    
    // List fetch request
    @FetchRequest(sortDescriptors: []) private var myListResults: FetchedResults<MyList>
    
    // Search results fetch request
    @FetchRequest(sortDescriptors: []) private var searchResults: FetchedResults<Reminder>
    
    @State private var isPresented: Bool = false
    @State private var search: String = ""
    @State private var isSearching: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    
                    HStack {
                        ReminderStatsView(icon: "calendar", title: "Today", count: 9)
                        ReminderStatsView(icon: "tray.circle.fill", title: "All", count: 4)
                    }
                    
                    HStack {
                        ReminderStatsView(icon: "calendar", title: "Today", count: 9)
                        ReminderStatsView(icon: "tray.circle.fill", title: "All", count: 4)
                    }
                    
                    MyListsView(myLists: myListResults)
                    
                    Button {
                        isPresented = true
                    } label: {
                        Text("Add List")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(.headline)
                    }
                    .padding()
                }
            }
            .navigationTitle("Reminders")
            .onChange(of: search, perform: { searchTerm in
                isSearching = !searchTerm.isEmpty ? true : false
                searchResults.nsPredicate = ReminderService.getRemindersBySearchTerm(search).predicate
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .center, content: {
                ReminderListView(reminders: searchResults)
                    .opacity(isSearching ? 1 : 0)
            })
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
            .padding()
        }
        .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always))
    }
    
    
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
