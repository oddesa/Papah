//
//  EksplorDetailViewModel.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

struct WBKL {
    let name: String
    let lng: Float
    let lat: Float
    let img: Data
    let operationalDay: String
    let operationalHour: String
    let address: String
    let phoneNumber: String
}

class EksplorDetailViewModel {
    
    let dummyData = (title: "Asdsd", desc: "asd")
    private var wbklData: WBKL
    
    init(wbklData: WBKL) {
        self.wbklData = wbklData
//        self.wblkData = wblkData
//        print("WBLK DATAAA \(self.wblkData)")
    }
    
}
