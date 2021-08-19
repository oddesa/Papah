//
//  TantanganDetailVielModel.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

struct ChallengeDetail {
    let id: Int?
    let img: UIImage?
    let title: String?
    var desc: String?
    
    static func getChallengeDetaileData(selectedRow: Int) -> [ChallengeDetail]{
        var cdData = [ChallengeDetail]()
        let img1 = UIImage(systemName: "mappin.and.ellipse")
        let img2 = UIImage(systemName: "iphone.homebutton")
        let img3 = UIImage(systemName: "text.badge.checkmark")
        let img4 = UIImage(systemName: "star")
        
        
        let cdData1 = ChallengeDetail(id: 0, img: img1, title: "1. Datang ke lokasi", desc: "Datang dan salurkan sampah ke lokasi agen sampah yang sudah kamu tentukan. Pastikan agen tersebut terdaftar di halaman “Eksplor”.")
        let cdData2 = ChallengeDetail(id: 0, img:img2, title: "2. Buka aplikasi", desc: "Masuk halaman “Eksplor” ➔ Temukan agen sampah tersebut ➔ Masuk halaman detail agen sampah.")
        let cdData3 = ChallengeDetail(id: 0, img: img3, title: "3. Input rincian limbah", desc: "Masukkan rincian sampah yang kamu salurkan di bagian “Rincian Sampah”.")
        let cdData4 = ChallengeDetail(id: 0, img: img4, title: "4. Klaim poin", desc: "Tekan tombol “Klaim Poin” di bagian bawah halaman. Ketika berhasil, pemberitahuan akan muncul sebagai tanda poin sudah bertambah.")
        
        let cdData5 = ChallengeDetail(id: 1, img: img1, title: "1. Datang ke lokasi", desc: "Datang dan salurkan sampah ke lokasi agen sampah yang sudah kamu tentukan. Pastikan agen tersebut terdaftar di halaman “Eksplor”.")
        let cdData6 = ChallengeDetail(id: 1, img:img2, title: "2. Buka aplikasi", desc: "Masuk halaman “Eksplor” ➔ Temukan agen sampah tersebut ➔ Masuk halaman detail agen sampah.")
        let cdData7 = ChallengeDetail(id: 1, img: img3, title: "3. Input rincian limbah", desc: "Masukkan rincian sampah yang kamu salurkan di bagian “Rincian Sampah”.")
        let cdData8 = ChallengeDetail(id: 1, img: img4, title: "4. Klaim poin", desc: "Tekan tombol “Klaim Poin” di bagian bawah halaman. Ketika poin berhasil diklaim, uang hasil penjualan sampah secara otomatis akan tertabung.")
        
        if selectedRow == 0{
            cdData.append(cdData1)
            cdData.append(cdData2)
            cdData.append(cdData3)
            cdData.append(cdData4)
        } else {
            cdData.append(cdData5)
            cdData.append(cdData6)
            cdData.append(cdData7)
            cdData.append(cdData8)
        }
        return cdData
    }
}

class TantanganDetailViewModel: NSObject {
    
    var challengeDetailData = [ChallengeDetail]()
    var selectedRow: Int = 0
    
    init(challengeDetailData: [ChallengeDetail], selectedRow: Int) {
        self.challengeDetailData = challengeDetailData
        self.selectedRow = selectedRow
    }
    
}
