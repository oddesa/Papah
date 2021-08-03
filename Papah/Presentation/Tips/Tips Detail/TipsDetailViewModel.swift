//
//  TipsDetailViewModel.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

class TipsDetailViewModel: NSObject {
    var tips: Sampah?
    init(tips: Sampah?){
        self.tips = tips
    }
    func getTipsDetail() -> [SampahDetail]?{
        return TipsDataRepository.shared.getTipsDetailById(sampahId: Int(self.tips?.sampah_id ?? 0))
        
    }
}
