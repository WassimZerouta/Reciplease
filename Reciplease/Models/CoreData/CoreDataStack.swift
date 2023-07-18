//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Wass on 01/03/2023.
//

import Foundation
import CoreData

final class CoreDataStack {
    
    private let persistentContainerName = "Reciplease"
    
    // MARK: - Singleton
    static let shared = CoreDataStack()
    
    // MARK: - Public

    var viewContext: NSManagedObjectContext {
        return CoreDataStack.shared.persistentContainer.viewContext
    }
    
    private init() {}
    
    // MARK: - Private

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: persistentContainerName)
        container.loadPersistentStores { storeDescription, error in
            if let error = error as? NSError {
                fatalError("Unresolved error \(error), \(error.userInfo) for \(storeDescription.description)")
            }
        }
        return container
    }()
}
