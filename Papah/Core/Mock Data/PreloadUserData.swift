//
//  s.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import Foundation
import UIKit
extension CoreDataManager {
    
    //MARK: Preload Badges
    func preloadUSer(){
    
        UserDataRepository.shared.addUser(userId: 0, email: "papah@gula.com", pw: "sugardaddy", level: 0, point: 0, totalUang: 0)
        
    }
}
