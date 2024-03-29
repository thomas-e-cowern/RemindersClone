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
    
    // Today reminders fetch request
    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(statType: .today))
    private var todayResults: FetchedResults<Reminder>
    
    // All remidners fetch request
    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(statType: .all))
    private var allResults: FetchedResults<Reminder>
    
    // Completed reminders fetch request
    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(statType: .completed))
    private var comletedResults: FetchedResults<Reminder>
    
    // Scheduled reminders fetch request
    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(statType: .scheduled))
    private var scheduleResults: FetchedResults<Reminder>
    
    @State private var isPresented: Bool = false
    @State private var search: String = ""
    @State private var isSearching: Bool = false
    
    private var reminderStatsBuilder = StatsBuilder()
    @State private var reminderStatValues = ReminderStatsValues()
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    
                    
                    HStack {
                        NavigationLink {
                            ReminderListView(reminders: todayResults)
                        } label: {
                            ReminderStatsView(icon: "calendar", title: "Today", count: reminderStatValues.todayCount, iconColor: .red)
                        }
                        
                        NavigationLink {
                            ReminderListView(reminders: allResults)
                        } label: {
                            ReminderStatsView(icon: "tray.circle.fill", title: "All", count: reminderStatValues.allCount, iconColor: .green)
                        }
                    }
                    
                    HStack {
                        
                        NavigationLink {
                            ReminderListView(reminders: scheduleResults)
                        } label: {
                            ReminderStatsView(icon: "calendar.circle.fill", title: "Scheduled", count: reminderStatValues.scheduledCount)
                        }
                        
                        NavigationLink {
                            ReminderListView(reminders: comletedResults)
                        } label: {
                            ReminderStatsView(icon: "checkmark.circle.fill", title: "Completed", count: reminderStatValues.completedCount)
                        }
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
            .onAppear {
                print("On Appear")
                reminderStatValues = reminderStatsBuilder.build(myListResults: myListResults)
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
            .padding()
        }
        .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always))
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
