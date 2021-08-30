//
//  PapahApp.swift
//  Watch Extension
//
//  Created by Dhiky Aldwiansyah on 20/08/21.
//

import SwiftUI

@main
struct PapahApp: App {
    let container = CoreDataManager.sharedManager.persistentContainer
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
            TabView {
                
                    ContentView()
                        
                        
                }.environment(\.managedObjectContext, container!.viewContext)
                .onAppear(perform: {
                    CoreDataManager.sharedManager.preloadData()
                })
            }.tabViewStyle(PageTabViewStyle())
            
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
