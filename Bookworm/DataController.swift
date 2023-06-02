//
//  DataController.swift
//  Bookworm
//
//  Created by Uriel Ortega on 30/05/23.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    // This container prepares CoreData to load the data in Bookworm datamodel.
    let container = NSPersistentContainer(name: "Bookworm") // This means: Use Bookworm.xcdatamodel
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
