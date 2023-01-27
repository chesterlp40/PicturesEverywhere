//
//  CoreDataManager.swift
//  PicturesEverywhere
//
//  Created by Ezequiel Rasgido on 27/01/2023.
//

import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    static let sharedInstance: CoreDataManager = CoreDataManager()
    
    private init() {
        ValueTransformer.setValueTransformer(
            UIImageTransformer(),
            forName: NSValueTransformerName("UIImageTransformer")
        )
        self.persistentContainer = NSPersistentContainer(
            name: "PicturesDataModel"
        )
        self.persistentContainer.loadPersistentStores { description, error in
            if let safeError = error {
                fatalError("Unable to initialize Core Data. \(safeError)")
            }
        }
    }
}
