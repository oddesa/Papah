//
//  s.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import Foundation
import UIKit
extension CoreDataManager {
    
    //MARK: Preload Badges
    func preloadBadgeProgress(){
        
        BadgeDataRepository.shared.insertBadgeProgress(badgeId: 0, bpId: 0, userId: 0, currentValue: 0, status: false)
        BadgeDataRepository.shared.insertBadgeProgress(badgeId: 1, bpId: 1, userId: 0, currentValue: 0, status: false)
        BadgeDataRepository.shared.insertBadgeProgress(badgeId: 2, bpId: 2, userId: 0, currentValue: 0, status: false)
        BadgeDataRepository.shared.insertBadgeProgress(badgeId: 3, bpId: 3, userId: 0, currentValue: 0, status: false)
        BadgeDataRepository.shared.insertBadgeProgress(badgeId: 4, bpId: 4, userId: 0, currentValue: 0, status: false)
        BadgeDataRepository.shared.insertBadgeProgress(badgeId: 5, bpId: 5, userId: 0, currentValue: 0, status: false)
        //monthly challenge
        BadgeDataRepository.shared.insertBadgeProgress(badgeId: 6, bpId: 6, userId: 0, currentValue: 2, status: true)
        BadgeDataRepository.shared.insertBadgeProgress(badgeId: 7, bpId: 7, userId: 0, currentValue: 0, status: false)

    }
    
    
    //MARK: Preload Badges
    func preloadBadges(){
        BadgeDataRepository.shared.insertBadge(
            badgeId: 0,
            badgeCategoryId: 0,
            title: "Kurcaci Penyalur",
            desc: "Peroleh medali ini ketika kamu berhasil menyalurkan total 15 kg sampah inorganik.", // Sejauh ini kamu sudah mengumpulkan ",
            maxValue: 15,
            dateAchv: Date(),
            image: UIImage._36, //hrusnya 36
            imgAchieved: UIImage._31
        )
        BadgeDataRepository.shared.insertBadge(
            badgeId: 1,
            badgeCategoryId: 1,
            title: "Veteran Kurcaci",
            desc: "Peroleh medali ini ketika anda berhasil mencapai Level 5.", //Saat ini kamu sudah ada di Level ",
            maxValue: 5,
            dateAchv: Date(),
            image: UIImage._39,
            imgAchieved: UIImage._33
        )
        BadgeDataRepository.shared.insertBadge(
            badgeId: 2,
            badgeCategoryId: 2,
            title: "Kurcaci Tajir",
            desc: "Peroleh medali ini ketika kamu berhasil mengumpulkan total Rp50k dari hasil penyaluran sampah inorganik.", //Sejauh ini kamu telah mengumpulkan Rp.",
            maxValue: 50000,
            dateAchv: Date(),
            image: UIImage._34,
            imgAchieved: UIImage._32
        )
        BadgeDataRepository.shared.insertBadge(
            badgeId: 3,
            badgeCategoryId: 3,
            title: "Kurcaci Pelopor",
            desc: "Peroleh medali ini ketika kamu berhasil menyalurkan 5 kategori sampah inorganik yang berbeda.", // Sejauh ini kamu sudah menyalurkan sekian kategori sampah.",
            maxValue: 5,
            dateAchv: Date(),
            image: UIImage._35,
            imgAchieved: UIImage._30
        )
        BadgeDataRepository.shared.insertBadge(
            badgeId: 6,
            badgeCategoryId: 4,
            title: "Tantangan Juli",
            desc: "Peroleh medali ini ketika kamu berhasil menyelesaikan 2 tantangan bulan Juli.",// Sejauh ini kamu telah menyelesaikan ",
            maxValue: 2,
            dateAchv: Date(),
            image: UIImage._37,
            imgAchieved: UIImage._29
        )
        BadgeDataRepository.shared.insertBadge(
            badgeId: 7,
            badgeCategoryId: 4,
            title: "Tantangan Agustus",
            desc: "Peroleh medali ini ketika kamu berhasil menyelesaikan 2 tantangan bulan Agustus.",// Sejauh ini kamu telah menyelesaikan ",
            maxValue: 2,
            dateAchv: Date(),
            image: UIImage._38,
            imgAchieved: UIImage._28
        )
       
    }
    
    //konfirm sama wurie
    func preloadBadgeCategory(){
        BadgeDataRepository.shared.insertBadgeCategory(
            badgeCategoryId: 0,
            title: "beratSampah",
            unit: "kg"
        )
        BadgeDataRepository.shared.insertBadgeCategory(
            badgeCategoryId: 1,
            title: "level",
            unit: "level"
        )
        BadgeDataRepository.shared.insertBadgeCategory(
            badgeCategoryId: 2,
            title: "profit",
            unit: "IDR"
        )
        BadgeDataRepository.shared.insertBadgeCategory(
            badgeCategoryId: 3,
            title: "kategoriSampah",
            unit: "kategori"
        )
        BadgeDataRepository.shared.insertBadgeCategory(
            badgeCategoryId: 4,
            title: "tantangan",
            unit: "tantangan"
        )
        BadgeDataRepository.shared.insertBadgeCategory(
            badgeCategoryId: 5,
            title: "agen",
            unit: "agen"
        )
    }
}
