//
//  WbklDataRepository.swift
//  Papah
//
//  Created by Delvina Janice on 30/07/21.
//

import Foundation
import CoreData
import UIKit

class WbklDataRepository {
    static let shared = WbklDataRepository()
    let wbklEntity = Wbkl.self.description()
    let wbklCategoryEntity = WasteCategory.self.description()
    let wbklAccEntity = WasteAccepted.self.description()
    
    func insertWbkl(id: Int,
                    name:String,
                    wbklType: String,
                    longitude: Float,
                    latitude: Float,
                    image: UIImage,
                    openDay: String,
                    openHour: String,
                    address:String,
                    phone: String,
                    claimedDate: Date){
        do {
            let context = CoreDataManager.sharedManager.persistentContainer.viewContext
            
            
            //add wbkl
            let wbklData = Wbkl(context: context)
            wbklData.wbkl_id = Int32(id)
            wbklData.name = name
            wbklData.wbkl_type = wbklType
            wbklData.longitude = longitude
            wbklData.latitude = latitude
            wbklData.image = image.jpegData(compressionQuality: 1.0)
            wbklData.operational_day = openDay
            wbklData.operational_hour = openHour
            wbklData.address = address
            wbklData.phone_number = phone
//            wbklData.claimed_date = claimedDate
            
            try context.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func insertWasteAccepted(wbklId: Int,
                             wasteAccId: Int,
                             wasteCategoryId: Int,
                             price: Int) {
        
        do {
            let context = CoreDataManager.sharedManager.persistentContainer.viewContext
            
            if let wbkl = getWbklById(wbklId: wbklId) {
                
                let wasteAcc = WasteAccepted(context: context)
                wasteAcc.waste_accepted_id = Int32(wasteAccId)
                wasteAcc.price = Int32(price)
                if let wasteCategory = getWasteCategoryById(id: wasteCategoryId) {
                    wasteAcc.wasteCategory = wasteCategory
                }
                wasteAcc.ofWbkl = wbkl
                wasteAcc.wbkl_id = Int32(wbklId)
                wasteAcc.waste_category_id = Int32(wasteCategoryId)

                wbkl.addToWasteAccepted(wasteAcc)
                
                try context.save()
            }
            
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func insertWasteCategory(wasteCategoryId: Int,
                             title: String,
                             unit: String,
                             image: Data) {
        
        do {
            let context = CoreDataManager.sharedManager.persistentContainer.viewContext
            
            let wasteCategory = WasteCategory(context: context)
            wasteCategory.image = image
            wasteCategory.unit = unit
            wasteCategory.waste_category_id = Int32(wasteCategoryId)
            wasteCategory.title = title

            try context.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func insertWasteCategoryToWbkl(wbklId: Int,
                                   wasteCategoryId: Int,
                                   title: String,
                                   unit: String,
                                   image: Data) {
        
        do {
            let context = CoreDataManager.sharedManager.persistentContainer.viewContext
            
            if let wbkl = getWbklById(wbklId: wbklId) {
                
                let wasteCategory = WasteCategory(context: context)
                wasteCategory.waste_category_id = Int32(wasteCategoryId)
                wasteCategory.title = title
                wasteCategory.unit = unit
                wasteCategory.image = image
                
                wbkl.addToWasteCategory(wasteCategory)
                
                try context.save()
            }
            
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func insertWasteCategoryToWasteAcc(id: Int,
                                       wasteCategoryId: Int,
                                       title: String,
                                       unit: String,
                                       image: Data) {
        
        do {
            let context = CoreDataManager.sharedManager.persistentContainer.viewContext
            
            if let wasteAcc = getWbklByWasteAccId(id: id) {
                
                let wasteCategory = WasteCategory(context: context)
                wasteCategory.waste_category_id = Int32(wasteCategoryId)
                wasteCategory.title = title
                wasteCategory.unit = unit
                wasteCategory.image = image
                
                //add to waste accepted
                wasteAcc.wasteCategory = wasteCategory
                
                try context.save()
            }
            
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    //MARK: Get Wbkl
    func getWbklById(wbklId: Int) -> Wbkl? {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: wbklEntity)
        fetchRequest.predicate = NSPredicate(format: "wbkl_id == %d", wbklId)
        
        do {
            
            let item = try context.fetch(fetchRequest) as? [Wbkl]
            
            return item?.first
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    func getWbklByWasteAccId(id: Int) -> WasteAccepted? {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: wbklAccEntity)
        fetchRequest.predicate = NSPredicate(format: "waste_accepted_id == %d", id)
        
        do {
            
            let item = try context.fetch(fetchRequest) as? [WasteAccepted]
            
            return item?.first
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    func getWasteCategoryById(id: Int) -> WasteCategory? {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: wbklCategoryEntity)
        fetchRequest.predicate = NSPredicate(format: "waste_category_id == %d", id)
        
        do {
            
            let item = try context.fetch(fetchRequest) as? [WasteCategory]
            
            return item?.first
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    func getWblkByName(name: String) -> [Wbkl]{
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: wbklEntity)
        fetchRequest.predicate = NSPredicate(format: "name == %d", name)
        
        do {
            
            let item = try context.fetch(fetchRequest) as! [Wbkl]
            
            return item
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return []
    }
    
    //on pending
    func getWbklByCategory(category: String) -> [Wbkl] {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: wbklCategoryEntity)
        fetchRequest.predicate = NSPredicate(format: "title == %d", category)
        
        do {
            
            let item = try context.fetch(fetchRequest) as! [Wbkl]
            
            return item
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return []
    }
    
    //onpending
    func getWbklByNameAndCategory(name: String, category: String) -> [Wbkl]{
        //bisa berdasar nama atau kategori
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: wbklEntity)
        fetchRequest.predicate = NSPredicate(format: "title == %d", category)
        
        do {
            
            let item = try context.fetch(fetchRequest) as! [Wbkl]
            
            return item
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return []
    }
    
    func getAllWbkl() -> [Wbkl] {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: wbklEntity)
        
        do {
            let item = try context.fetch(fetchRequest) as! [Wbkl]
            return item
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return []
    }
    
    
    //MARK: Delete Wbkl
    func deleteAllWbKl(){
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        do {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: wbklEntity)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
}

