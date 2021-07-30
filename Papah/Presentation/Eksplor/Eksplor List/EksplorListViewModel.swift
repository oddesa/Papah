//
//  EksplorListViewModel.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

struct KangLoak {
    let name: String
    let jenis: String
    let jarak: String
    let kategori: [String]
    let operasional: String
}

class EksplorListViewModel: NSObject {

    let dataGblk = KangLoak(name: "Bank Sampah Mak Cimet", jenis: "Godmother", jarak: "100 bulan purnama", kategori: ["Plastik", "Mantan", "Penjahat"], operasional: "Buka, 00.01-23.59")
    
    init(dummy: Int){
        
    }
    
}
