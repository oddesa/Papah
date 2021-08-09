//
//  PreloadWBKLData.swift
//  Papah
//
//  Created by Dhiky Aldwiansyah on 04/08/21.
//

import Foundation
import UIKit

extension CoreDataManager {
    
    //MARK: Preload Wbkl
    func preloadDataWbkl(){
        WbklDataRepository.shared.insertWbkl(
            id: 0,
            name: "Lapak rongsok RDK",
            wbklType: "Mall Rongsok",
            longitude:  106.819412,
            latitude: -6.600046,
            image: UIImage.wbklLapakRongsokRDK,
            openDay: "Senin - Minggu",
            openHour: "07.00 - 22.00",
            address: "Jl. Kp. Sawah, Tanah Baru, Kec. Bogor Utara, Kota Bogor, Jawa Barat",
            phone: "+6285773094034",
            claimedDate: Date()
        )
        
        WbklDataRepository.shared.insertWbkl(
            id: 1,
            name: "BSU Cendana",
            wbklType: "Bank Sampah Unit",
            longitude: 106.779389,
            latitude: -6.594889,
            image: UIImage.wbklBankSampahUnitCendana,
            openDay: "Rabu",
            openHour: "08.00 - 12.00",
            address: "Jl. Raya Gn. Batu No.5, RT.06/RW.03, Pasir Jaya, Kecamatan Bogor Baru, Kota Bogor, Jawa Barat 16610",
            phone: "+6281384151188",
            claimedDate: Date()
        )
        
        WbklDataRepository.shared.insertWbkl(
            id: 2,
            name: "BSU Warung Jambu Bersih",
            wbklType: "Bank Sampah Unit",
            longitude: 106.810273,
            latitude: -6.567949,
            image: UIImage.wbklBankSampahWarungJambuBersih,
            openDay: "Senin - Minggu",
            openHour: "00.00 - 24.00",
            address: "Warung Jambu Rt.02/06 (Belakang Kantor Pos, RT.03/RW.01, Bantarjati, Kec. Bogor Utara, Kota Bogor, Jawa Barat 16151",
            phone: "+6281385143538",
            claimedDate: Date()
        )
        
        WbklDataRepository.shared.insertWbkl(
            id: 3,
            name: "CV Cahaya Berkah",
            wbklType: "Mall Rongsok",
            longitude: 106.819158,
            latitude: -6.607226,
            image: UIImage.wbklCvCahayaBerkah,
            openDay: "Senin - Minggu",
            openHour: "08.00 - 16.00",
            address: "Jl. Kol. Ahmad Syam, RT.01/RW.05, Katulampa, Kec. Bogor Tim., Kota Bogor, Jawa Barat 16143",
            phone: "+6282123488049",
            claimedDate: Date()
        )
        
        WbklDataRepository.shared.insertWbkl(
            id: 4,
            name: "BSU Rangga Mekar",
            wbklType: "Bank Sampah Unit",
            longitude: 106.797850,
            latitude: -6.621504,
            image: UIImage.wbklBSURanggaMekar,
            openDay: "Senin - Minggu",
            openHour: "08.00 - 17.00",
            address: "Jl. Graha Bogor Indah No.1327, RT.01/RW.04, Ranggamekar, Kec. Bogor Sel., Kota Bogor, Jawa Barat 16136",
            phone: "+6285777742100",
            claimedDate: Date()
        )
    }
    
}

extension CoreDataManager {
    func preloadWasteCategoryofWbkl(){
        WbklDataRepository.shared.insertWasteCategoryToWbkl(
            wbklId: 0,
            wasteCategoryId: 0,
            title: "Besi",
            unit: "kg",
            image: UIImage._1
        )
        WbklDataRepository.shared.insertWasteCategoryToWbkl(
            wbklId: 0,
            wasteCategoryId: 8,
            title: "Perabotan",
            unit: "item",
            image: UIImage._9
        )
        WbklDataRepository.shared.insertWasteCategoryToWbkl(
            wbklId: 0,
            wasteCategoryId: 3,
            title: "Kardus",
            unit: "kg",
            image: UIImage._4
        )
        WbklDataRepository.shared.insertWasteCategoryToWbkl(
            wbklId: 1,
            wasteCategoryId: 0,
            title: "Besi",
            unit: "kg",
            image: UIImage._1
        )
        WbklDataRepository.shared.insertWasteCategoryToWbkl(
            wbklId: 1,
            wasteCategoryId: 2,
            title: "Kaca",
            unit: "kg",
            image: UIImage._3
        )
        WbklDataRepository.shared.insertWasteCategoryToWbkl(
            wbklId: 1,
            wasteCategoryId: 9,
            title: "Plastik",
            unit: "kg",
            image: UIImage._10
        )
        WbklDataRepository.shared.insertWasteCategoryToWbkl(
            wbklId: 1,
            wasteCategoryId: 3,
            title: "Kardus",
            unit: "kg",
            image: UIImage._4
        )
        WbklDataRepository.shared.insertWasteCategoryToWbkl(
            wbklId: 1,
            wasteCategoryId: 6,
            title: "Kertas",
            unit: "kg",
            image: UIImage._7
        )
        WbklDataRepository.shared.insertWasteCategoryToWbkl(
            wbklId: 1,
            wasteCategoryId: 4,
            title: "Karet",
            unit: "kg",
            image: UIImage._5
        )
        WbklDataRepository.shared.insertWasteCategoryToWbkl(
            wbklId: 2,
            wasteCategoryId: 1,
            title: "Duplek",
            unit: "kg",
            image: UIImage._2
        )
        WbklDataRepository.shared.insertWasteCategoryToWbkl(
            wbklId: 2,
            wasteCategoryId: 0,
            title: "Besi",
            unit: "kg",
            image: UIImage._1
        )
        WbklDataRepository.shared.insertWasteCategoryToWbkl(
            wbklId: 2,
            wasteCategoryId: 2,
            title: "Kaca",
            unit: "kg",
            image: UIImage._3
        )
        WbklDataRepository.shared.insertWasteCategoryToWbkl(
            wbklId: 2,
            wasteCategoryId: 7,
            title: "Minyak Jelantah",
            unit: "kg",
            image: UIImage._8
        )
        WbklDataRepository.shared.insertWasteCategoryToWbkl(
            wbklId: 2,
            wasteCategoryId: 5,
            title: "Karung Goni",
            unit: "kg",
            image: UIImage._6
        )
        WbklDataRepository.shared.insertWasteCategoryToWbkl(
            wbklId: 2,
            wasteCategoryId: 9,
            title: "Plastik",
            unit: "kg",
            image: UIImage._10
        )
        WbklDataRepository.shared.insertWasteCategoryToWbkl(
            wbklId: 2,
            wasteCategoryId: 3,
            title: "Kardus",
            unit: "kg",
            image: UIImage._4
        )
        WbklDataRepository.shared.insertWasteCategoryToWbkl(
            wbklId: 3,
            wasteCategoryId: 8,
            title: "Perabotan",
            unit: "Item",
            image: UIImage._9
        )
        WbklDataRepository.shared.insertWasteCategoryToWbkl(
            wbklId: 4,
            wasteCategoryId: 1,
            title: "Duplek",
            unit: "kg",
            image: UIImage._2
        )
        WbklDataRepository.shared.insertWasteCategoryToWbkl(
            wbklId: 4,
            wasteCategoryId: 0,
            title: "Besi",
            unit: "kg",
            image: UIImage._1
        )
        WbklDataRepository.shared.insertWasteCategoryToWbkl(
            wbklId: 4,
            wasteCategoryId: 9,
            title: "Plastik",
            unit: "kg",
            image: UIImage._10
        )
        WbklDataRepository.shared.insertWasteCategoryToWbkl(
            wbklId: 4,
            wasteCategoryId: 3,
            title: "Kardus",
            unit: "kg",
            image: UIImage._4
        )
        WbklDataRepository.shared.insertWasteCategoryToWbkl(
            wbklId: 4,
            wasteCategoryId: 6,
            title: "Kertas",
            unit: "kg",
            image: UIImage._7
        )
        WbklDataRepository.shared.insertWasteCategoryToWbkl(
            wbklId: 4,
            wasteCategoryId: 2,
            title: "Kaca",
            unit: "kg",
            image: UIImage._3
        )
    }
    
    
    //MARK: Waste Category
    func preloadWasteCategory(){
            WbklDataRepository.shared.insertWasteCategory(wasteCategoryId: 0,title: "Besi",unit: "kg",image: UIImage._1)
            WbklDataRepository.shared.insertWasteCategory(wasteCategoryId: 1,title: "Duplek",unit: "kg",image: UIImage._2)
            WbklDataRepository.shared.insertWasteCategory(wasteCategoryId: 2,title: "Kaca",unit: "kg",image: UIImage._3)
            WbklDataRepository.shared.insertWasteCategory(wasteCategoryId: 3,title: "Kardus",unit: "kg",image: UIImage._4)
            WbklDataRepository.shared.insertWasteCategory(wasteCategoryId: 4,title: "Karet",unit: "kg",image: UIImage._5)
            WbklDataRepository.shared.insertWasteCategory(wasteCategoryId: 5,title: "Karung Goni",unit: "kg",image: UIImage._6)
            WbklDataRepository.shared.insertWasteCategory(wasteCategoryId: 6,title: "Kertas",unit: "kg",image: UIImage._7)
            WbklDataRepository.shared.insertWasteCategory(wasteCategoryId: 7,title: "Minyak Jelantah",unit: "kg",image: UIImage._8)
            WbklDataRepository.shared.insertWasteCategory(wasteCategoryId: 8,title: "Perabotan",unit: "kg",image: UIImage._9)
            WbklDataRepository.shared.insertWasteCategory(wasteCategoryId: 9, title: "Plastik", unit: "kg", image: UIImage._10)
    }
    
    //MARK: Waste Category
    func preloadWasteAccWbkl(){
        WbklDataRepository.shared.insertWasteAccepted(wbklId: 0, wasteAccId: 0, wasteCategoryId: 0, price: 1000)
        WbklDataRepository.shared.insertWasteAccepted(wbklId: 0, wasteAccId: 1, wasteCategoryId: 9, price: 1000)
        WbklDataRepository.shared.insertWasteAccepted(wbklId: 0, wasteAccId: 1, wasteCategoryId: 3, price: 1000)
        
        WbklDataRepository.shared.insertWasteAccepted(wbklId: 1, wasteAccId: 1, wasteCategoryId: 0, price: 1000)
        WbklDataRepository.shared.insertWasteAccepted(wbklId: 1, wasteAccId: 1, wasteCategoryId: 2, price: 1000)
        WbklDataRepository.shared.insertWasteAccepted(wbklId: 1, wasteAccId: 1, wasteCategoryId: 9, price: 1000)
        WbklDataRepository.shared.insertWasteAccepted(wbklId: 1, wasteAccId: 1, wasteCategoryId: 3, price: 1000)
        WbklDataRepository.shared.insertWasteAccepted(wbklId: 1, wasteAccId: 1, wasteCategoryId: 6, price: 1000)
        WbklDataRepository.shared.insertWasteAccepted(wbklId: 1, wasteAccId: 1, wasteCategoryId: 4, price: 1000)

        WbklDataRepository.shared.insertWasteAccepted(wbklId: 2, wasteAccId: 1, wasteCategoryId: 1, price: 1000)
        WbklDataRepository.shared.insertWasteAccepted(wbklId: 2, wasteAccId: 1, wasteCategoryId: 0, price: 1000)
        WbklDataRepository.shared.insertWasteAccepted(wbklId: 2, wasteAccId: 1, wasteCategoryId: 2, price: 1000)
        WbklDataRepository.shared.insertWasteAccepted(wbklId: 2, wasteAccId: 1, wasteCategoryId: 7, price: 1000)
        WbklDataRepository.shared.insertWasteAccepted(wbklId: 2, wasteAccId: 1, wasteCategoryId: 5, price: 1000)
        WbklDataRepository.shared.insertWasteAccepted(wbklId: 2, wasteAccId: 1, wasteCategoryId: 9, price: 1000)
        WbklDataRepository.shared.insertWasteAccepted(wbklId: 2, wasteAccId: 1, wasteCategoryId: 3, price: 1000)

        WbklDataRepository.shared.insertWasteAccepted(wbklId: 3, wasteAccId: 1, wasteCategoryId: 8, price: 1000)
        
        WbklDataRepository.shared.insertWasteAccepted(wbklId: 4, wasteAccId: 1, wasteCategoryId: 1, price: 1000)
        WbklDataRepository.shared.insertWasteAccepted(wbklId: 4, wasteAccId: 1, wasteCategoryId: 0, price: 1000)
        WbklDataRepository.shared.insertWasteAccepted(wbklId: 4, wasteAccId: 1, wasteCategoryId: 9, price: 1000)
        WbklDataRepository.shared.insertWasteAccepted(wbklId: 4, wasteAccId: 1, wasteCategoryId: 3, price: 1000)
        WbklDataRepository.shared.insertWasteAccepted(wbklId: 4, wasteAccId: 1, wasteCategoryId: 6, price: 1000)
        WbklDataRepository.shared.insertWasteAccepted(wbklId: 4, wasteAccId: 1, wasteCategoryId: 2, price: 1000)

    }
    
}
