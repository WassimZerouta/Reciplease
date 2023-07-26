//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Wass on 01/03/2023.
//

import Foundation
import CoreData

protocol CoreDataStackProtocol {
    var viewContext: NSManagedObjectContext { get }
    var persistentContainer: NSPersistentContainer { get }
}

final class CoreDataStack: CoreDataStackProtocol {
    
    private let persistentContainerName = "Reciplease"
    
    // MARK: - Singleton
    static let shared = CoreDataStack()
    
    // MARK: - Public

    var viewContext: NSManagedObjectContext {
        return CoreDataStack.shared.persistentContainer.viewContext
    }
    
    private init() {}
    

     lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: persistentContainerName)
        container.loadPersistentStores { storeDescription, error in
            if let error = error as? NSError {
                fatalError("Unresolved error \(error), \(error.userInfo) for \(storeDescription.description)")
            }
        }
        return container
    }()
}

final class TestCoreDataStack: CoreDataStackProtocol {
    
    private let persistentContainerName = "Reciplease"

    static let shared = TestCoreDataStack()
    
    var viewContext: NSManagedObjectContext {
        return TestCoreDataStack.shared.persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let description = NSPersistentStoreDescription()
        description.url = URL(fileURLWithPath: "/dev/null")
        let container = NSPersistentContainer(name: persistentContainerName)
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
}
