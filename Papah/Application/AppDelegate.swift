//
//  AppDelegate.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
            
        CoreDataManager.sharedManager.preloadData()
        
//        WbklDataRepository.shared.insertWasteCategory(wasteCategoryId: 1, title: "Plastik", unit: "Kg", image: Data())
//        WbklDataRepository.shared.insertWasteCategory(wasteCategoryId: 2, title: "Kertas", unit: "Kg", image: Data())
//        WbklDataRepository.shared.insertWasteCategory(wasteCategoryId: 3, title: "Galon", unit: "Kg", image: Data())
//        
//        WbklDataRepository.shared.insertWasteAccepted(wbklId: 0, wasteAccId: 1, wasteCategoryId: 1, price: 1000)
//        WbklDataRepository.shared.insertWasteAccepted(wbklId: 0, wasteAccId: 2, wasteCategoryId: 2, price: 1000)
//        WbklDataRepository.shared.insertWasteAccepted(wbklId: 0, wasteAccId: 3, wasteCategoryId: 3, price: 1000)

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
