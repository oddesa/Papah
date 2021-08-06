//
//  TantanganDetailVielModel.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

struct ChallengeDetail {
    let id: String = UUID().uuidString
    let img: UIImage?
    let title: String?
    var desc: String?
    
    static func getChallengeDetaileData() -> [ChallengeDetail]{
        var cdData = [ChallengeDetail]()
        let img1 = UIImage(systemName: "mappin.and.ellipse")
        let img2 = UIImage(systemName: "iphone.homebutton")
        let img3 = UIImage(systemName: "text.badge.checkmark")
        let img4 = UIImage(systemName: "star")
        
        
        let cdData1 = ChallengeDetail(img: img1, title: "1. Datang ke lokasi", desc: "Datang dan salurkan limbah ke lokasi agen yang kamu tentukan. Pastikan agen tersebut terdaftar di halaman eksplor.")
        let cdData2 = ChallengeDetail(img:img2, title: "2. Buka aplikasi", desc: "Masuk halaman eksplor > temukan agen limbah tersebut > masuk halaman detail agen limbah.")
        let cdData3 = ChallengeDetail(img: img3, title: "3. Input rincian limbah", desc: "Masukkan rincian limbah yang kamu salurkan di bagian “Rincian Limbah”.")
        let cdData4 = ChallengeDetail(img: img4, title: "4. Klaim poin", desc: "Tekan tombol “Klaim poin” di bagian bawah halaman. Ketika berhasil, informasi pop-up akan muncul. Poin kamu sudah bertambah!")
        
        
        cdData.append(cdData1)
        cdData.append(cdData2)
        cdData.append(cdData3)
        cdData.append(cdData4)
        
        return cdData
    }
}

class TantanganDetailViewModel: NSObject {
    
    var challengeDetailData = [ChallengeDetail]()
    
    init(challengeDetailData: [ChallengeDetail]) {
        self.challengeDetailData = challengeDetailData
    }
    
}
