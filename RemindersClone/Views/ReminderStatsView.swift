//
//  ReminderStatsView.swift
//  RemindersClone
//
//  Created by Thomas Cowern on 1/15/24.
//

import SwiftUI

struct ReminderStatsView: View {
    
    let icon: String
    let title: String
    var count: Int?
    var iconColor: Color? = .blue
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Image(systemName: icon)
                        .foregroundStyle(iconColor ?? .blue)
                        .font(.title)
                    Text(title)
                        .opacity(0.8)
                }
                
                Spacer()
                
                if let count {
                    Text("\(count)")
                        .font(.largeTitle)
                }
            }
        }
        .padding()
        .border(colorScheme == .dark ? .white : .black)
        .frame(maxWidth: .infinity)
        
    }
}

#Preview {
    Group {
        ReminderStatsView(icon: "calendar", title: "Today", count: 9, iconColor: .blue)
            .padding()
            .background(Color(.systemBackground))
            .environment(\.colorScheme, .light)
            .previewDisplayName("Light")
        
        ReminderStatsView(icon: "calendar", title: "Today", count: 9, iconColor: .blue)
            .padding()
            .background(Color(.systemBackground))
            .environment(\.colorScheme, .dark)
            .previewDisplayName("Dark")
    }
}
