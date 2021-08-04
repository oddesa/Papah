//
//  PreloadUserData.swift
//  Papah
//
//  Created by Delvina Janice on 05/08/21.
//

import Foundation

extension CoreDataManager{
    func preloadUserIntialData(){
        UserDataRepository.shared.addUser(
            userId: 0,
            email: "asdf@gmail.com",
            pw: "asdf",
            level: 2,
            point: 0,
            totalUang: 500000
        )
    }
}
