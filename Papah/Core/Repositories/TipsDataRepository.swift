//
//  MedicineBasket.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 09/04/21.
//

import Foundation
import CoreData
import UIKit

class TipsDataRepository {
    
    static let shared = TipsDataRepository()
    let entityName = Sampah.self.description()
    let entityNameSampahDetail = SampahDetail.self.description()

    func insertTips(title: String,
                    desc: String,
                    sampahId: Int,
                    image: UIImage) {
        
        do {
            let context = CoreDataManager.sharedManager.persistentContainer.viewContext
            
            //Add evaluation photo
            let evaluationDetails = Sampah(context: context)
            evaluationDetails.title = title
            evaluationDetails.desc = desc
            evaluationDetails.image = image.jpegData(compressionQuality: 1.0)
            evaluationDetails.sampah_id = Int32(sampahId)
            
            try context.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    
    func insertTipsDetail(title: String,
                          detail: String,
                          sampahId: Int,
                          sampahDetailId: Int,
                          image: UIImage) {
        
        do {
            
            let context = CoreDataManager.sharedManager.persistentContainer.viewContext
            
            if let tips = getTipsById(sampahId: sampahId) {
                
                let tipsDetail = SampahDetail(context: context)
                tipsDetail.title = title
                tipsDetail.detail = detail
                tipsDetail.image = image.jpegData(compressionQuality: 1.0)
                tipsDetail.sampah_id = Int32(sampahId)
                print("SAMPAH ID TIPS DETAIL \(Int32(sampahId))")
                tips.addToSampahDetail(tipsDetail)
                
                try context.save()
            }
            
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func getTipsById(sampahId: Int) -> Sampah? {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "sampah_id == %i", sampahId)
        
        do {
            
            let item = try context.fetch(fetchRequest) as? [Sampah]
            
            return item?.first
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        
        return nil
    }
    
    
    
    func getAllTips() -> [Sampah]? {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            
            let item = try context.fetch(fetchRequest) as? [Sampah]
            
            return item
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return []
    }
    
    
    func getTipsDetailById(sampahId: Int) -> [SampahDetail]? {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityNameSampahDetail)
        fetchRequest.predicate = NSPredicate(format: "sampah_id == %d", sampahId)
        
        do {
            
            let item = try context.fetch(fetchRequest) as? [SampahDetail]
                        
            return item
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    
    
    func deleteTips(data: Sampah) {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        do {
            context.delete(data)
            try context.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    
    func deleteAllTips() {
        
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
