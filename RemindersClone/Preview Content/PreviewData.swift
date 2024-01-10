//
//  PreviewData.swift
//  RemindersClone
//
//  Created by Thomas Cowern on 1/10/24.
//

import Foundation
import CoreData

class PreviewData {
    static var myList: MyList {
        let viewContext = CoreDataProvider.shared.persistentContainer.viewContext
        let request = MyList.fetchRequest()
        return (try? viewContext.fetch(request).first) ?? MyList()
    }
}
