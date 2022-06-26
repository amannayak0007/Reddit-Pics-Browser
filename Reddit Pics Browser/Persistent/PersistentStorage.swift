//
//  PersistentStorage.swift
//  Reddit Pics Browser
//
//  Created by AMAN JAIN on 26/06/22.
//

import Foundation
import CoreData

final class PersistentStorage {
    
    private init() {}
    
    static let shared = PersistentStorage()
    lazy var context = persistentContainer.viewContext
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Reddit_Pics_Browser")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
