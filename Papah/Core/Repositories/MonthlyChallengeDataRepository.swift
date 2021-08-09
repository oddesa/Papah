//
//  MonthlyChallengeDataRepository.swift
//  Papah
//
//  Created by Delvina Janice on 31/07/21.
//

import Foundation
import CoreData
import UIKit

class MonthlyChallengeDataRepository {
    
    static let shared = MonthlyChallengeDataRepository()
    let montlyChallengeEntity = MonthlyChallenge.self.description()
    let mcpEntity = MonthlyChallengeProgress.self.description()
    
    func insertMonthlyChallenge(userId: Int,
                                badgeCategoryId: Int,
                                mcId: Int,
                                title: String,
                                desc: String,
                                month: Int,
                                rewardPoint: Int,
                                maxValue: Int,
                                image: UIImage) {
        
        do {
            let context = CoreDataManager.sharedManager.persistentContainer.viewContext
            
            //Add monthlyChallenge
            let monthlyChallenge = MonthlyChallenge(context: context)
            
            if let badgeCategory = BadgeDataRepository.shared.getBadgeCategoryById(id: badgeCategoryId) {
                monthlyChallenge.badgeCategory = badgeCategory

            }
            
            monthlyChallenge.user_id = Int32(userId)
            monthlyChallenge.badge_category_id = Int32(badgeCategoryId)
            monthlyChallenge.monthly_challenge_id = Int32(mcId)
            monthlyChallenge.title = title
            monthlyChallenge.desc = desc
            monthlyChallenge.month = Int32(month)
            monthlyChallenge.reward_point = Int32(rewardPoint)
            monthlyChallenge.max_value = Float(maxValue)
            monthlyChallenge.image = image.pngData()
            
          
            
            try context.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    
    func insertMonthlyChallengeProgress(userId: Int,
                                        mcId: Int,
                                        mcpId: Int,
                                        status: Bool,
                                        currentValue: Float) {
        
        do {
            
            let context = CoreDataManager.sharedManager.persistentContainer.viewContext
            
            if let monthlyChallenge = getMonthlyChallengeByMCId(id: mcId) {
                
                let mcProgress = MonthlyChallengeProgress(context: context)
                mcProgress.user_id = Int32(userId)
                mcProgress.monthly_challenge_id = Int32(mcId)
                mcProgress.mcp_id = Int32(mcpId)
                mcProgress.status = status
                mcProgress.current_value = currentValue
                
                monthlyChallenge.addToMonthlyCP(mcProgress)
                
                try context.save()
            }
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    //MARK: Get
    func getMonthlyChallengeByMCId(id: Int) -> MonthlyChallenge? {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: montlyChallengeEntity)
        fetchRequest.predicate = NSPredicate(format: "monthly_challenge_id == %d", id)
        
        do {
            
            let item = try context.fetch(fetchRequest) as? [MonthlyChallenge]
            
            return item?.first
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        
        return nil
    }
    
    func getAllMonthlyChallenge() -> [MonthlyChallenge]? {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: montlyChallengeEntity)
        
        do {
            
            let item = try context.fetch(fetchRequest) as? [MonthlyChallenge]
            
            return item
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return []
    }
    
    func getMonthlyChallengebyMonth(currentMonth: Int) -> [MonthlyChallenge]? {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: montlyChallengeEntity)
        fetchRequest.predicate = NSPredicate(format: "month == %d", currentMonth)
        
        do {
            
            let item = try context.fetch(fetchRequest) as? [MonthlyChallenge]
            
            return item
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return []
    }
    
    
    func getCurrentChallengeCompleted(month: Int) -> [MonthlyChallengeProgress]? {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: mcpEntity)
        fetchRequest.predicate = NSPredicate(format: "status == %d", true)
        
        do {
            
            var item = try context.fetch(fetchRequest) as? [MonthlyChallengeProgress]
            
            item = item?.filter { $0.monthlyChallenge?.month == Int32(month)}
            
            return item
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return []
    }
    
    
    func getMCPById(mcpId: Int) -> [MonthlyChallengeProgress]? {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: mcpEntity)
        fetchRequest.predicate = NSPredicate(format: "mcp_id == %d", mcpId)
        
        do {
            
            let item = try context.fetch(fetchRequest) as? [MonthlyChallengeProgress]
            
            return item
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    
    func getAllMonthlyChallengeProgress() -> [MonthlyChallengeProgress]? {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: mcpEntity)
        
        do {
            
            let item = try context.fetch(fetchRequest) as? [MonthlyChallengeProgress]
            
            return item
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    func getMCPByUserID(userId: Int) -> [MonthlyChallengeProgress]? {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: mcpEntity)
        fetchRequest.predicate = NSPredicate(format: "user_id == %d", userId)
        
        do {
            
            let item = try context.fetch(fetchRequest) as? [MonthlyChallengeProgress]
            
            return item
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    func getMCPByUserIdAndMonth(userId: Int, currentMonth:Int) -> [MonthlyChallengeProgress]? {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: mcpEntity)
        fetchRequest.predicate = NSPredicate(format: "user_id == %d", userId)
        
        do {
            
            var item = try context.fetch(fetchRequest) as? [MonthlyChallengeProgress]
            
            item = item?.filter { $0.monthlyChallenge?.month == Int32(currentMonth)}
            
            return item
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    //MARK: Update
    func updateMonthlyChallengeProgress(mcpId: Int, value: Float){
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: mcpEntity)
        fetchRequest.predicate = NSPredicate(format: "mcp_id == %d", mcpId)
        
        do {
            let item = try context.fetch(fetchRequest) as? [MonthlyChallengeProgress]
            
            let mcp = item?.first
            let currentValue = mcp?.current_value ?? 0
            let totalValue = currentValue + value
            
            if let monthlyChallenge = mcp?.monthlyChallenge {
                
                if mcp?.mcp_id == monthlyChallenge.monthly_challenge_id {
                    let maxValue = monthlyChallenge.max_value
                    if mcp?.status == false {
                        if maxValue > totalValue {
                            mcp?.current_value = totalValue
                        } else {
                            mcp?.current_value = maxValue
                            mcp?.status = true
                            
                            UserDataRepository.shared.updatePoint(userId: 0, newPoint: Int(mcp?.monthlyChallenge?.reward_point ?? 0))

                        }
                    }
                }
                try context.save()
            }
            

//            let fetchMC = NSFetchRequest<NSManagedObject>(entityName: montlyChallengeEntity)
//            fetchMC.predicate = NSPredicate(format: "monthly_challenge_id == %d", mcId)
//            do {
//                let monthlyChallenge = try context.fetch(fetchRequest) as? [MonthlyChallenge]
//
//                let mc = monthlyChallenge?.first
//
//                if mcp?.mcp_id == mc?.monthly_challenge_id {
//                    let maxValue = mc?.max_value ?? 0
//                    if mcp?.status == false {
//                        if maxValue > totalValue {
//                            mcp?.current_value = totalValue
//                        } else {
//                            mcp?.current_value = maxValue
//                            mcp?.status = true
//
//                            UserDataRepository.shared.updatePoint(userId: 0, newPoint: Int(mcp?.monthlyChallenge?.reward_point ?? 0))
//
//                        }
//                    }
//                }
//
//                try context.save()
//
//            } catch let error as NSError {
//                print("Could not save. \(error), \(error.userInfo)")
//            }

        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //MARK: Delete
    func deleteMonthlyChallenge(data: MonthlyChallenge) {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func deleteAllMonthlyChallenge() {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        do {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: montlyChallengeEntity)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
}
