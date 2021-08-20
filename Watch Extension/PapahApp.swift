//
//  PapahApp.swift
//  Watch Extension
//
//  Created by Dhiky Aldwiansyah on 20/08/21.
//

import SwiftUI

@main
struct PapahApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
