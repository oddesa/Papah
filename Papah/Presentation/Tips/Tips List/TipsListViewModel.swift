//
//  TipsListViewModel.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

class TipsListViewModel: NSObject {
    
    var tipsData: [Sampah]?
    
    let tipsRepository = TipsDataRepository.shared
    
    func getTipsData() -> [Sampah]? {
        CoreDataManager.sharedManager.preloadDataTips()
        return tipsRepository.getAllTips()
    }
}
