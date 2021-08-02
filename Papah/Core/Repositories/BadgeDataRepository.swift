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
    let badgeEntity = Badge.self.description()
    let badgeCategoryEntity = BadgeCategory.self.description()
    let badgeProgressEntity = BadgeProgress.self.description()
    
    func insertBadge(badgeId: Int,
                     badgeCategoryId: Int,
                     title: String,
                     desc: String,
                     maxValue: Float,
                     dateAchv: Date,
                     image: UIImage) {
        
        do {
            let context = CoreDataManager.sharedManager.persistentContainer.viewContext
            
            //Add badge
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
                badge.badgeCategory = badgeCategory
                
                try context.save()
            }
            
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //MARK: Get
    func getBadgeById(id: Int) -> Badge? {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: badgeEntity)
        fetchRequest.predicate = NSPredicate(format: "badge_id == %d", id)
        
        do {
            
            let item = try context.fetch(fetchRequest) as? [Badge]
            
            return item?.first
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        
        return nil
    }
    
    func getBadgeProgressbyId(bpId: Int) -> BadgeProgress? {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: badgeProgressEntity)
        fetchRequest.predicate = NSPredicate(format: "bp_id == %d", bpId)
        
        do {
            
            let item = try context.fetch(fetchRequest) as? [BadgeProgress]
            
            return item?.first
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        
        return nil
    }
    
    func getAllBadges() -> [Badge]? {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: badgeEntity)
        
        do {
            
            let item = try context.fetch(fetchRequest) as? [Badge]
            
            return item
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return []
    }
    
    //MARK: Update
    func updateBagdeProgress(badgeId: Int, bpId: Int, value: Float) -> Bool{
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let bpFetchRequest = NSFetchRequest<NSManagedObject>(entityName: badgeProgressEntity)
        bpFetchRequest.predicate = NSPredicate(format: "bp_id == %d", bpId)
        
        do {
            let item = try context.fetch(bpFetchRequest) as? [BadgeProgress]
            let bp = item?.first
            let badgeFetchRequest = NSFetchRequest<NSManagedObject>(entityName: badgeEntity)
            badgeFetchRequest.predicate = NSPredicate(format: "badge_id == %d", badgeId)
            
            do {
                let fetchedBadge = try context.fetch(bpFetchRequest) as? [Badge]
                
                let badge = fetchedBadge?.first
                
                if bp?.id == badge?.id {
                    if bp?.status == false {
                        let maxValue = badge?.max_value ?? 0
                        let totalValue = bp?.current_value ?? 0 + value
                       
                        if totalValue < maxValue {
                            bp?.current_value = totalValue
                        } else {
                            bp?.current_value = maxValue
                            bp?.status = true
                        }
                    }
                }
                //return "Badge Progress Update Success"
                return true
            }
            catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

        //return "Could not update badge progress"
        return false
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
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: badgeEntity)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
}
