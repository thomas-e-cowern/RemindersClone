//
//  StatsBuilder.swift
//  RemindersClone
//
//  Created by Thomas Cowern on 1/15/24.
//

import Foundation
import SwiftUI

struct ReminderStatsValues {
    var todayCount: Int = 0
    var scheduledCount: Int = 0
    var allCount: Int = 0
    var completedCount: Int = 0
}

struct StatsBuilder {
    
    func build(myListResults: FetchedResults<MyList>) -> ReminderStatsValues {
        
        let remindersArray = myListResults.map { $0.remindersArray }.reduce([], +)
    }
    
}
