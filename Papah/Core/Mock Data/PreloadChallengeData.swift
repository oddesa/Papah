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
    func preloadBadges(){
        BadgeDataRepository.shared.insertBadge(
            badgeId: 0,
            badgeCategoryId: 0,
            title: "Delko Kurcaci",
            desc: "Peroleh medali ini ketika kamu berhasil menyalurkan total 15 kg sampah inorganik. Sejauh ini kamu sudah mengumpulkan ",
            maxValue: 15,
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
        BadgeDataRepository.shared.insertBadge(
            badgeId: 4,
            badgeCategoryId: 4,
            title: "Tantangan Juli",
            desc: "Peroleh medali ini ketika kamu berhasil menyelesaikan 2 tantangan bulan Agustus. Sejauh ini kamu telah menyelesaikan ",
            maxValue: 2,
            dateAchv: Date(),
            image: UIImage()
        )
        BadgeDataRepository.shared.insertBadge(
            badgeId: 5,
            badgeCategoryId: 4,
            title: "Tantangan Agustus",
            desc: "Peroleh medali ini ketika kamu berhasil menyelesaikan 2 tantangan bulan Agustus. Sejauh ini kamu telah menyelesaikan ",
            maxValue: 2,
            dateAchv: Date(),
            image: UIImage()
        )
    }
    
    //konfirm sama wurie
    func preloadBadgeCategory(){
        BadgeDataRepository.shared.insertBadgeCategory(
            badgeId: 0,
            badgeCategoryId: 0,
            title: "beratSampah",
            unit: "kg"
        )
        BadgeDataRepository.shared.insertBadgeCategory(
            badgeId: 1,
            badgeCategoryId: 1,
            title: "level",
            unit: "level"
        )
        BadgeDataRepository.shared.insertBadgeCategory(
            badgeId: 2,
            badgeCategoryId: 2,
            title: "profit",
            unit: "IDR"
        )
        BadgeDataRepository.shared.insertBadgeCategory(
            badgeId: 3,
            badgeCategoryId: 3,
            title: "kategoriSampah",
            unit: "kategori"
        )
        BadgeDataRepository.shared.insertBadgeCategory(
            badgeId: 4,
            badgeCategoryId: 4,
            title: "tantangan",
            unit: "tantangan"
        )
        BadgeDataRepository.shared.insertBadgeCategory(
            badgeId: 4,
            badgeCategoryId: 5,
            title: "agen",
            unit: "agen"
        )
    }
    
    //MARK: Preload Monthly Challenge
    func preloadMonthlyChallenges(){
        MonthlyChallengeDataRepository.shared.insertMonthlyChallenge(
            userId: 0,
            badgeCategoryId: 5,
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
            maxValue: 50000,
            image: UIImage()
        )
        
        MonthlyChallengeDataRepository.shared.insertMonthlyChallenge(
            userId: 0,
            badgeCategoryId: 5,
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
            maxValue: 50000,
            image: UIImage()
        )
    }
    
    func preloadMonthlyChallengeProgress(){
        MonthlyChallengeDataRepository.shared.insertMonthlyChallengeProgress(
            userId: 0,
            mcId: 0,
            mcpId: 0,
            status: true,
            currentValue: 1
        )
        
        MonthlyChallengeDataRepository.shared.insertMonthlyChallengeProgress(
            userId: 0,
            mcId: 1,
            mcpId: 1,
            status: true,
            currentValue: 50000
        )
        
        MonthlyChallengeDataRepository.shared.insertMonthlyChallengeProgress(
            userId: 0,
            mcId: 2,
            mcpId: 2,
            status: false,
            currentValue: 0
        )
        
        MonthlyChallengeDataRepository.shared.insertMonthlyChallengeProgress(
            userId: 0,
            mcId: 3,
            mcpId: 3,
            status: false,
            currentValue: 0
        )
    }
}
