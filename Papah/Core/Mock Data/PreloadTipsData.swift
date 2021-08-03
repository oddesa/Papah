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
}

//MARK: Preload Tips Details
extension CoreDataManager {
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
}
