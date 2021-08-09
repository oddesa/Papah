//
//  PreloadTipsData.swift
//  Papah
//
//  Created by Dhiky Aldwiansyah on 04/08/21.
//

import Foundation
import UIKit

//MARK: Preload Tips
extension CoreDataManager {
    func preloadDataTips(){
        
        //Plastik
        TipsDataRepository.shared.insertTips(
            title: "Plastik",
            desc: "Ini bahan dimana-mana, tapi mau dibawa kemana?",
            sampahId: 0,
            image: UIImage._11
        )
        
        //Kaca
        TipsDataRepository.shared.insertTips(
            title: "Kaca",
            desc: "Beling kaca memang berbahaya, tapi ada solusinya",
            sampahId: 1,
            image: UIImage._14
        )
        
        //Kaleng
        TipsDataRepository.shared.insertTips(
            title: "Kaleng & Styrofoam",
            desc: "Minuman kaleng berserakan? Yuk kita rapihkan",
            sampahId: 2,
            image: UIImage._13
        )
        
        //Kertas
        TipsDataRepository.shared.insertTips(
            title: "Kertas dan Kardus",
            desc: "Kertas dan kardus, jangan cuma dilapas tapi diurus",
            sampahId: 3,
            image: UIImage._12
        )
    }
}

//MARK: Preload Tips Details
extension CoreDataManager {
    func preloadDataTipsDetail(){
        
        //Plastik
        TipsDataRepository.shared.insertTipsDetail(
            title: "Kenapa mendaur ulang",
            detail: "Tahukah kamu? Sampah plastik sangat sulit untuk terurai. Bahkan, diperlukan waktu sekitar 500 tahun! Belum lagi plastik mudah disalahartikan sebagai makanan oleh burung dan ikan. Jadi, yuk mulai mendaur ulang plastik untuk selamatkan bumi. ",
            sampahId: 0,
            sampahDetailId: 12,
            image:  UIImage._15
        )
        TipsDataRepository.shared.insertTipsDetail(
            title: "Memilah botol plastik",
            detail: "Pastikan botol dibersihkan dan kering. Pisahkan botol bening dangan yang berwarna. Lalu pisahkan tutup botol dari botolnya dan cabut stiker plastik yang menempel bila ada. Baru gepengkan botol plastik yang sudah dikategorikan tersebut.",
            sampahId: 0,
            sampahDetailId: 13,
            image: UIImage._16
        )
        TipsDataRepository.shared.insertTipsDetail(
            title: "Kantong plastik",
            detail: "Keluarkan benda apapun dari dalam kantong plastik. Kemudian kumpulkan dan simpan semua kantong plastik yang sudah bersih dan kering ke satu kantong sampah besar. Karena mudah dipadatkan, satu kantong sampah dapat memuat 50 - 100 kantong plastik. ",
            sampahId: 0,
            sampahDetailId: 14,
            image: UIImage._17
        )
        TipsDataRepository.shared.insertTipsDetail(
            title: "Tidak diterima",
            detail: "Sampah plastikmu belum layak untuk di salurkan jika; basah, kotor, belum diremas dan terdapat benda lain seperti; kuitansi, stiker, dan remah-remah.",
            sampahId: 0,
            sampahDetailId: 15,
            image: UIImage._18
        )
        
        //Kaca
        TipsDataRepository.shared.insertTipsDetail(
            title: "Why?",
            detail: "Manfaat dari daur ulang kaca: mengurangi emisi dan konsumsi bahan mentah, memperpanjang umur peralatan pabrik, seperti tungku, dan menghemat energi.",
            sampahId: 1,
            sampahDetailId: 0,
            image: UIImage()
        )
        TipsDataRepository.shared.insertTipsDetail(
            title: "Pilah Botol/Toples Kacamu",
            detail: "Pastikan botol/toples dibersihkan dan kering",
            sampahId: 1,
            sampahDetailId: 1,
            image: UIImage()
        )
        TipsDataRepository.shared.insertTipsDetail(
            title: "Pilah Botol/Toples Kacamu",
            detail: "Satukan botol/toples dengan diikat tali plastik atau digabungkan disatu plastik/dus",
            sampahId: 1,
            sampahDetailId: 2,
            image: UIImage()
        )
        TipsDataRepository.shared.insertTipsDetail(
            title: "Tidak diterima",
            detail: "Jangan salurkan botol/plastik yang sudah hancur/pecah",
            sampahId: 1,
            sampahDetailId: 3,
            image: UIImage()
        )
        
        //Kaleng
        TipsDataRepository.shared.insertTipsDetail(
            title: "Why?",
            detail: "Mendaur ulang 1kg Aluminium dapat menghemat listrik hingga 14kWh.",
            sampahId: 2,
            sampahDetailId: 4,
            image: UIImage()
        )
        TipsDataRepository.shared.insertTipsDetail(
            title: "Pilah Kaleng",
            detail: "Pastikan kaleng dibersihkan dan kering",
            sampahId: 2,
            sampahDetailId: 5,
            image: UIImage()
        )
        TipsDataRepository.shared.insertTipsDetail(
            title: "Pilah Kaleng",
            detail: "Gepengkan Kaleng",
            sampahId: 2,
            sampahDetailId: 6,
            image: UIImage()
        )
        TipsDataRepository.shared.insertTipsDetail(
            title: "Tidak diterima",
            detail: "Kotor",
            sampahId: 2,
            sampahDetailId: 7,
            image: UIImage()
        )
        
        //Kertas dan Kardus
        TipsDataRepository.shared.insertTipsDetail(
            title: "Why?",
            detail: "Dengan mendaur ulang 1 ton kertas, kamu telah menyelamatkan 17 pohon dan 3.3m kubik ruang TPA",
            sampahId: 3,
            sampahDetailId: 8,
            image: UIImage()
        )
        TipsDataRepository.shared.insertTipsDetail(
            title: "Pilah kertas lembaran/koran",
            detail: "Pisahkan dari yang sudah kotor, satukan kertas lembaran/koran secara bertumpuk,",
            sampahId: 3,
            sampahDetailId: 9,
            image: UIImage()
        )
        TipsDataRepository.shared.insertTipsDetail(
            title: "Pilah dus/majalah",
            detail: "Pisahkan dari yang sudah kotor, Pisahkan dari hekter/jilid-an dari dus/majalah, satukan kertas lembaran/koran secara bertumpuk.",
            sampahId: 3,
            sampahDetailId: 10,
            image: UIImage()
        )
        TipsDataRepository.shared.insertTipsDetail(
            title: "Tidak diterima",
            detail: "Kotor, basah, berminyak, tisu lembaran atau kertas robekan",
            sampahId: 3,
            sampahDetailId: 11,
            image: UIImage()
        )
       
    }
}
