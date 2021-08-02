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

    let wbklRepository = WbklDataRepository.shared
    
    let dataGblk = KangLoak(name: "Bank Sampah Mak Cimet", jenis: "Godmother", jarak: "100 bulan purnama", kategori: ["Plastik", "Mantan", "Penjahat"], operasional: "Buka, 00.01-23.59")
    
    func getWBklData() -> [Wbkl]? {
        return wbklRepository.getAllWbkl()
    }
        
}

//    let wbklData = WBKL(name: "nama", lng: 1, lat: 2, img: UIImage.whatsAppImage20210719At085013.jpegData(compressionQuality: 1.0) ?? Data(), operationalDay: "08:00", operationalHour: "08:00", address: "213", phoneNumber: "123")
