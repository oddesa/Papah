//
//  UserDataRepository.swift
//  Papah
//
//  Created by Delvina Janice on 31/07/21.
//

import Foundation
import CoreData
import UIKit

class UserDataRepository {
    
    static let shared = UserDataRepository()
    let entityName = User.self.description()
    
    func addUser(userId: Int,
                email: String,
                pw: String,
                level: Int,
                point: Int,
                totalUang: Int) {
        
        do {
            let context = CoreDataManager.sharedManager.persistentContainer.viewContext
            
            let user = User(context: context)
            user.user_id = Int32(userId)
            user.email = email
            user.password = pw
            user.level = Int32(level)
            user.point = Int32(point)
            user.total_uang = Int32(totalUang)
            
            try context.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func getUserById(id: Int) -> User? {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "user_id == %d", id)
        
        do {
            
            let item = try context.fetch(fetchRequest) as? [User]
            
            return item?.first
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        
        return nil
    }
    
    //MARK:Update User
    func updateProfile() {
        
    }
    
    func updateTotalUang(userId: Int, income: Int) {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "user_id == %d", userId)
        
        do {
            
            let item = try context.fetch(fetchRequest) as? [User]
            let user = item?.first
            let totalUang = user?.total_uang ?? 0
            
            user?.total_uang = totalUang + Int32(income)
            
            try context.save()

        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func updatePoint(userId: Int, newPoint: Int){
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "user_id == %d", userId)
        
        do {
            
            let item = try context.fetch(fetchRequest) as? [User]
            let user = item?.first
            let userPoint = Int(user?.point ?? 0)
            let userLevel = Int(user?.level ?? 1)
            
            let totalPoint = userPoint + newPoint
            let userLevelScope = Constants.userLevelScope
            
            if userLevelScope > totalPoint {
                user?.point = Int32(totalPoint)
            } else if userLevelScope == totalPoint {
                user?.point = 0
                user?.level = Int32(userLevel + 1)
            } else {
                user?.point = Int32(totalPoint - userPoint)
                user?.level = Int32(userLevel + 1)
            }
            
            try context.save()

        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    
    
    func deleteUser(data: User) {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func deleteAllUser() {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        do {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
}

