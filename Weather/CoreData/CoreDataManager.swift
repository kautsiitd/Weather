//
//  CoreDataManager.swift
//  Weather
//
//  Created by Kautsya Kanu on 22/02/21.
//

import CoreData
final class CoreDataManager {
    //MARK: Properties
    static let shared = CoreDataManager()
    private init() {}
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Weather")
        container.loadPersistentStores { description, error in
            if let error = error { NSLog(error.localizedDescription) }}
        return container
    }()
}

//MARK:- Available Functions
extension CoreDataManager {
    func save(context: NSManagedObjectContext) {
        context.perform {
            if context.hasChanges { try? context.save() }
        }
    }
}
