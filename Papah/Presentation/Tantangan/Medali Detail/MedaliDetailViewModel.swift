//
//  MedaliDetailViewModel.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

struct MedaliDetailData {
    var image: UIImage
    var title: String
    var desc: String
}

class MedaliDetailViewModel: NSObject {
    var datas = [MedaliDetailData]()
    init(datasVM: [MedaliDetailData]) {
        self.datas = datasVM
    }
    
}
