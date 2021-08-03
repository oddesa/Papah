//
//  CoreDataManage.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let sharedManager = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: Constants.dataModel)
        
        
        container.loadPersistentStores(completionHandler: { (_, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
    }()
    
    func saveContext () {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func deleteAllData() {
        
        let storeCoordinator = persistentContainer.persistentStoreCoordinator
        let storeDescription = persistentContainer.persistentStoreDescriptions[0]
        guard let storeURL = storeDescription.url else {
            return
        }
        
        do {
            try storeCoordinator.destroyPersistentStore(at: storeURL, ofType: NSSQLiteStoreType, options: nil)
        } catch {
            return
        }
        
        storeCoordinator.addPersistentStore(with: storeDescription) {
            (_, error) in
            
            if let error = error {
                print("\(error)")
            }
        }
        
        //Reload the data again
        preloadData()
    }
    
}

//MARK: PreloadData
extension CoreDataManager {
    func preloadData() {
        
    }
    
    //MARK: Preload Tips
    func preloadDataTips(){
        TipsDataRepository.shared.insertTips(
            title: "Kaca",
            desc: "Banyak botol kaca? Lakukan tips berikut untuk memilahnya",
            sampahId: 0,
            image: UIImage()
        )
        TipsDataRepository.shared.insertTips(
            title: "Kaleng",
            desc: "Suka minum minuman berkarbonat? Ayo pilah, daripada buang",
            sampahId: 1,
            image: UIImage()
        )
        TipsDataRepository.shared.insertTips(
            title: "Kertas dan Kardus",
            desc: "Pelajari bagaimana cara menyalurkannya",
            sampahId: 2,
            image: UIImage()
        )
        TipsDataRepository.shared.insertTips(
            title: "Perabot",
            desc: "Rumahmu penuh dengan perabot tidak terpakai? Ayo cek yang bisa kamu salurkan!",
            sampahId: 3,
            image: UIImage()
        )
        TipsDataRepository.shared.insertTips(
            title: "Plastik",
            desc: "Hal-hal yang harus kamu ketahui untuk memilah plastik",
            sampahId: 4,
            image: UIImage()
        )
    }
    
    //MARK: Preload Tips Details
    func preloadDataTipsDetail(){
        //Kaca
        TipsDataRepository.shared.insertTipsDetail(
            title: "Why?",
            detail: "Manfaat dari daur ulang kaca: mengurangi emisi dan konsumsi bahan mentah, memperpanjang umur peralatan pabrik, seperti tungku, dan menghemat energi.",
            sampahId: 0,
            sampahDetailId: 0,
            image: UIImage()
        )
        TipsDataRepository.shared.insertTipsDetail(
            title: "Pilah Botol/Toples Kacamu",
            detail: "Pastikan botol/toples dibersihkan dan kering",
            sampahId: 0,
            sampahDetailId: 1,
            image: UIImage()
        )
        TipsDataRepository.shared.insertTipsDetail(
            title: "Pilah Botol/Toples Kacamu",
            detail: "Satukan botol/toples dengan diikat tali plastik atau digabungkan disatu plastik/dus",
            sampahId: 0,
            sampahDetailId: 2,
            image: UIImage()
        )
        TipsDataRepository.shared.insertTipsDetail(
            title: "Tidak diterima",
            detail: "Jangan salurkan botol/plastik yang sudah hancur/pecah",
            sampahId: 0,
            sampahDetailId: 3,
            image: UIImage()
        )
        
        //Kaleng
        TipsDataRepository.shared.insertTipsDetail(
            title: "Why?",
            detail: "Mendaur ulang 1kg Aluminium dapat menghemat listrik hingga 14kWh.",
            sampahId: 1,
            sampahDetailId: 4,
            image: UIImage()
        )
        TipsDataRepository.shared.insertTipsDetail(
            title: "Pilah Kaleng",
            detail: "Pastikan kaleng dibersihkan dan kering",
            sampahId: 1,
            sampahDetailId: 5,
            image: UIImage()
        )
        TipsDataRepository.shared.insertTipsDetail(
            title: "Pilah Kaleng",
            detail: "Gepengkan Kaleng",
            sampahId: 1,
            sampahDetailId: 6,
            image: UIImage()
        )
        TipsDataRepository.shared.insertTipsDetail(
            title: "Tidak diterima",
            detail: "Kotor",
            sampahId: 1,
            sampahDetailId: 7,
            image: UIImage()
        )
        
        //Kertas dan Kardus
        TipsDataRepository.shared.insertTipsDetail(
            title: "Why?",
            detail: "Dengan mendaur ulang 1 ton kertas, kamu telah menyelamatkan 17 pohon dan 3.3m kubik ruang TPA",
            sampahId: 2,
            sampahDetailId: 8,
            image: UIImage()
        )
        TipsDataRepository.shared.insertTipsDetail(
            title: "Pilah kertas lembaran/koran",
            detail: "Pisahkan dari yang sudah kotor, satukan kertas lembaran/koran secara bertumpuk,",
            sampahId: 2,
            sampahDetailId: 9,
            image: UIImage()
        )
        TipsDataRepository.shared.insertTipsDetail(
            title: "Pilah dus/majalah",
            detail: "Pisahkan dari yang sudah kotor, Pisahkan dari hekter/jilid-an dari dus/majalah, satukan kertas lembaran/koran secara bertumpuk.",
            sampahId: 2,
            sampahDetailId: 10,
            image: UIImage()
        )
        TipsDataRepository.shared.insertTipsDetail(
            title: "Tidak diterima",
            detail: "Kotor, basah, berminyak, tisu lembaran atau kertas robekan",
            sampahId: 2,
            sampahDetailId: 11,
            image: UIImage()
        )
        
        //Plastik
        TipsDataRepository.shared.insertTipsDetail(
            title: "Why?",
            detail: "Faktanya bahwa plastik sangat sulit terurai, memerlukan hingga 500 tahun. Kantong plastik adalah salah satu sumber sampah laut yang paling umum, di mana mereka dapat disalahartikan sebagai makanan oleh burung dan ikan. ",
            sampahId: 4,
            sampahDetailId: 12,
            image: UIImage()
        )
        TipsDataRepository.shared.insertTipsDetail(
            title: "Pilah botol plastik",
            detail: "Pastikan botol dibersihkan dan kering. Pisahkan tutup botol dari botolnya, Cabut plastik mereknya bila ada, Pisahkan botol bening dan berwarna, Gepengkan botol plastik",
            sampahId: 4,
            sampahDetailId: 13,
            image: UIImage()
        )
        TipsDataRepository.shared.insertTipsDetail(
            title: "Pilah Cup Plastik",
            detail: "Pastikan cup gelas dibersihkan dan kering, Robek segel plastik cup gelas, Gepengkan cup gelas",
            sampahId: 4,
            sampahDetailId: 14,
            image: UIImage()
        )
        TipsDataRepository.shared.insertTipsDetail(
            title: "Pilah Kantong Plastik",
            detail: "Keluarkan apa pun di dalam kantong plastik, Simpan di satu kantong sampah besar untuk semua kantong plastik. Karena mudah dipadatkan, satu kantong sampah dapat memuat 50 - 100 kantong plastik",
            sampahId: 4,
            sampahDetailId: 15,
            image: UIImage()
        )
        TipsDataRepository.shared.insertTipsDetail(
            title: "Tidak diterima",
            detail: "Kotor, terdapat benda lain, seperti kuitansi, stiker, remah-remah ",
            sampahId: 4,
            sampahDetailId: 16,
            image: UIImage()
        )
    }
    
    //MARK: Preload Wbkl
    func preloadDataWbkl(){
        WbklDataRepository.shared.insertWbkl(
            id: 0,
            name: "Lapak rongsok RDK",
            wbklType: "Mall Rongsok",
            longitude:  -6.600046,
            latitude: 106.819412,
            image: UIImage.wbklLapakRongsokRDK,
            openDay: "Senin-Minggu",
            openHour: "07.00 - 22.00",
            address: "Jl. Kp. Sawah, Tanah Baru, Kec. Bogor Utara, Kota Bogor, Jawa Barat",
            phone: "+6285773094034",
            claimedDate: Date()
        )
        
        WbklDataRepository.shared.insertWbkl(
            id: 1,
            name: "Bank Sampah Unit Cendana",
            wbklType: "Bank Sampah",
            longitude: -6.594889,
            latitude: 106.779389,
            image: UIImage.wbklBankSampahUnitCendana,
            openDay: "Rabu",
            openHour: "08.00-12.00",
            address: "Jl. Raya Gn. Batu No.5, RT.06/RW.03, Pasir Jaya, Kecamatan Bogor Baru, Kota Bogor, Jawa Barat 16610",
            phone: "+6281384151188",
            claimedDate: Date()
        )
        
        WbklDataRepository.shared.insertWbkl(
            id: 2,
            name: "Bank Sampah Warung Jambu Bersih",
            wbklType: "Bank Sampah",
            longitude: -6.567949,
            latitude: 106.810273,
            image: UIImage.wbklBankSampahWarungJambuBersih,
            openDay: "Minggu",
            openHour: "10.00-14.00",
            address: "Warung Jambu Rt.02/06 (Belakang Kantor Pos, RT.03/RW.01, Bantarjati, Kec. Bogor Utara, Kota Bogor, Jawa Barat 16151",
            phone: "+6281385143538",
            claimedDate: Date()
        )
        
        WbklDataRepository.shared.insertWbkl(
            id: 3,
            name: "CV Cahaya Berkah",
            wbklType: "Mall Rongsok",
            longitude: -6.607226,
            latitude: 106.819158,
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
            longitude: -6.621504,
            latitude: 106.797850,
            image: UIImage.wbklBSURanggaMekar,
            openDay: "Senin - Minggu",
            openHour: "08.00 - 17.00",
            address: "Jl. Graha Bogor Indah No.1327, RT.01/RW.04, Ranggamekar, Kec. Bogor Sel., Kota Bogor, Jawa Barat 16136",
            phone: "+6285777742100",
            claimedDate: Date()
        )
    }
    
    //MARK: Preload Badges
    func preloadBadges(){
        BadgeDataRepository.shared.insertBadge(
            badgeId: 0,
            badgeCategoryId: 0,
            title: "Delko Limbah",
            desc: "1 dari 3 kunjungan",
            maxValue: 3,
            dateAchv: Date(),
            image: UIImage()
        )
        BadgeDataRepository.shared.insertBadge(
            badgeId: 1,
            badgeCategoryId: 1,
            title: "Veteran Kurcaci",
            desc: "Peroleh medali ini ketika anda berhasil mencapai Level 5. Saat ini kamu sudah ada di Level ",
            maxValue: 5,
            dateAchv: Date(),
            image: UIImage()
        )
        BadgeDataRepository.shared.insertBadge(
            badgeId: 2,
            badgeCategoryId: 2,
            title: "Crazy Rich Kurcaci",
            desc: "Peroleh medali ini ketika kamu berhasil mengumpulkan total Rp50k dari hasil penyaluran sampah inorganik. Sejauh ini kamu telah mengumpulkan Rp.",
            maxValue: 1000,
            dateAchv: Date(),
            image: UIImage()
        )
        BadgeDataRepository.shared.insertBadge(
            badgeId: 3,
            badgeCategoryId: 3,
            title: "Kurcaci Pelopor",
            desc: "Peroleh medali ini ketika kamu berhasil menyalurkan 5 kategori sampah inorganik yang berbeda. Sejauh ini kamu sudah menyalurkan sekian kategori sampah.",
            maxValue: 5,
            dateAchv: Date(),
            image: UIImage()
        )
    }
    
    //konfirm sama wurie
    func preloadBadgeCategory(){
        BadgeDataRepository.shared.insertBadgeCategory(
            badgeId: 0,
            badgeCategoryId: 0,
            title: "",
            unit: ""
        )
        BadgeDataRepository.shared.insertBadgeCategory(
            badgeId: 0,
            badgeCategoryId: 1,
            title: "",
            unit: ""
        )
    }
    
    //MARK: Preload Monthly Challenge
    func preloadMonthlyChallenges(){
        MonthlyChallengeDataRepository.shared.insertMonthlyChallenge(
            userId: 0,
            badgeCategoryId: 0,
            mcId: 0,
            title: "Turis Sampah",
            desc: "Salurkan limbah & klaim poin ke 1 agen",
            month: 7,
            rewardPoint: 300,
            maxValue: 1,
            image: UIImage()
        )
        
        MonthlyChallengeDataRepository.shared.insertMonthlyChallenge(
            userId: 0,
            badgeCategoryId: 2,
            mcId: 1,
            title: "Sultan Limbah",
            desc: "Kumpulkan Rp50k dari penyaluran limbah",
            month: 7,
            rewardPoint: 300,
            maxValue: 50,
            image: UIImage()
        )
        
        MonthlyChallengeDataRepository.shared.insertMonthlyChallenge(
            userId: 0,
            badgeCategoryId: 0,
            mcId: 2,
            title: "Turis Sampah",
            desc: "Salurkan limbah & klaim poin ke 1 agen",
            month: 8,
            rewardPoint: 300,
            maxValue: 1,
            image: UIImage()
        )
        
        MonthlyChallengeDataRepository.shared.insertMonthlyChallenge(
            userId: 0,
            badgeCategoryId: 2,
            mcId: 3,
            title: "Sultan Limbah",
            desc: "Kumpulkan Rp50k dari penyaluran limbah",
            month: 8,
            rewardPoint: 300,
            maxValue: 50,
            image: UIImage()
        )
    }
    
    func preloadMonthlyChallengeProgress(){
        MonthlyChallengeDataRepository.shared.insertMonthlyChallengeProgress(
            userId: 0,
            mcId: 0,
            mcpId: 0,
            status: true,
            currentValue: 300
        )
        
        MonthlyChallengeDataRepository.shared.insertMonthlyChallengeProgress(
            userId: 0,
            mcId: 1,
            mcpId: 1,
            status: true,
            currentValue: 300
        )
        
        MonthlyChallengeDataRepository.shared.insertMonthlyChallengeProgress(
            userId: 0,
            mcId: 2,
            mcpId: 2,
            status: false,
            currentValue: 300
        )
        
        MonthlyChallengeDataRepository.shared.insertMonthlyChallengeProgress(
            userId: 0,
            mcId: 3,
            mcpId: 3,
            status: false,
            currentValue: 300
        )
    }
}
