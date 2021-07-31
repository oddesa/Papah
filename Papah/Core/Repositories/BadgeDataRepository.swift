//
//  BadgeDataRepository.swift
//  Papah
//
//  Created by Delvina Janice on 31/07/21.
//

import Foundation
import CoreData
import UIKit

class BadgeDataRepository {
    
    static let shared = BadgeDataRepository()
    let entityName = Badge.self.description()
    
    func insertBadge(badgeId: Int,
                     badgeCategoryId: Int,
                     title: String,
                     desc: String,
                     maxValue: Float,
                     dateAchv: Date,
                     image: UIImage) {
        
        do {
            let context = CoreDataManager.sharedManager.persistentContainer.viewContext
            
            //Add evaluation photo
            let badge = Badge(context: context)
            badge.badge_id = Int32(badgeId)
            badge.title = title
            badge.desc = desc
            badge.max_value = maxValue
            badge.date_achieved = dateAchv
            badge.image = image.jpegData(compressionQuality: 1.0)

            
            try context.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func insertBadgeProgress(badgeId: Int,
                             bpId: Int,
                             userId: Int,
                             currentValue: Float,
                             status: Bool) {
        
        do {
            
            let context = CoreDataManager.sharedManager.persistentContainer.viewContext
            
            if let badge = getBadgeById(id: badgeId) {
                
                let badgeProgress = BadgeProgress(context: context)
                badgeProgress.badge_id = Int32(badgeId)
                badgeProgress.bp_id = Int32(bpId)
                badgeProgress.user_id = Int32(userId)
                badgeProgress.current_value = currentValue
                badgeProgress.status = status
                
                badge.addToBadgeProgress(badgeProgress)
                
                try context.save()
            }
            
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func insertBadgeCategory(badgeId: Int,
                             badgeCategoryId: Int,
                             title: String,
                             unit: String) {
        
        do {
            
            let context = CoreDataManager.sharedManager.persistentContainer.viewContext
            
            if let badge = getBadgeById(id: badgeId) {
                
                let badgeCategory = BadgeCategory(context: context)
                badgeCategory.badge_category_id = Int32(badgeCategoryId)
                badgeCategory.title = title
                badgeCategory.unit = unit
                
                //add to badge category
                
                
                try context.save()
            }
            
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //MARK: Get
    func getBadgeById(id: Int) -> Badge? {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "badge_id == %d", id)
        
        do {
            
            let item = try context.fetch(fetchRequest) as? [Badge]
            
            return item?.first
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        
        return nil
    }
    
    func getBadgeProgressbyId(bpId: Int) -> BadgeCategory? {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "bp_id == %d", bpId)
        
        do {
            
            let item = try context.fetch(fetchRequest) as? [BadgeCategory]
            
            return item?.first
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        
        return nil
    }
    
    func getAllBadges() -> [Badge]? {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            
            let item = try context.fetch(fetchRequest) as? [Badge]
            
            return item
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return []
    }
    
    
    //MARK: Delete
    func deleteBadge(data: Badge) {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    
    func deleteAllBadges() {
        
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
