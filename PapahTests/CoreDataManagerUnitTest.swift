//
//  CoreDataManage.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import Foundation
import CoreData
import UIKit

@testable import Papah

class CoreDataManagerUniTest {
    
    static func mockContainer() -> NSPersistentContainer{
        let container = NSPersistentContainer(name: Constants.dataModel)

        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false

        container.persistentStoreDescriptions = [description]

        container.loadPersistentStores(completionHandler: { (_, error) in
            precondition( description.type == NSInMemoryStoreType )
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
    }
}
