//
//  s.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import Foundation
import UIKit
extension CoreDataManager {
    
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
