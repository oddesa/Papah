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
    let entityName = MonthlyChallenge.self.description()
    
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
            monthlyChallenge.user_id = Int32(userId)
            monthlyChallenge.badge_category_id = Int32(badgeCategoryId)
            monthlyChallenge.monthly_challenge_id = Int32(mcId)
            monthlyChallenge.title = title
            monthlyChallenge.desc = desc
            monthlyChallenge.month = Int32(month)
            monthlyChallenge.reward_point = Int32(rewardPoint)
            monthlyChallenge.max_value = Float(maxValue)
            monthlyChallenge.image = image.jpegData(compressionQuality: 1.0)
            
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
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
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
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            
            let item = try context.fetch(fetchRequest) as? [MonthlyChallenge]
            
            return item
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return []
    }
    
    
    func getMCPById(mcpId: Int) -> [MonthlyChallengeProgress]? {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "mcp_id == %d", mcpId)
        
        do {
            
            let item = try context.fetch(fetchRequest) as? [MonthlyChallengeProgress]
            
            return item
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    //MARK: Update
    func updateMonthlyChallengeProgress(mcpId: Int, value: Float) -> Bool{
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "mcp_id == %d", mcpId)
        
        do {
            
            let item = try context.fetch(fetchRequest) as? MonthlyChallengeProgress
            
            
            let totalValue = item?.current_value ?? 0 + value
            /*Pseudo:
             if maxValue > totalValue maka currentValue = totalValue
             else maka currentValue == maxValue
             status claim_avail == true
            */
            item?.current_value =  totalValue
            
            return true
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return false
    }
    
    func claimMonthlyChallengePoints() {
        /*Pseudo:
         masukin claimed date
         claim_avail == false
         status claimed == true
         panggil fungsi add user point di vc nya
        */
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
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
}
