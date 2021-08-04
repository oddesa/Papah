//
//  TantanganListViewModel.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

class TantanganListViewModel: NSObject {
    var user: User?
    var monthlyChallenge: [MonthlyChallenge]?
    var badges: Badge?
    
    func getUserData() -> User? {
        if user == nil {
            user = UserDataRepository.shared.getUserById(id: 0)
        }
        return user
    }
    
    func getMonthlyChallenge() -> [MonthlyChallenge]? {
        if monthlyChallenge == nil {
            monthlyChallenge = MonthlyChallengeDataRepository.shared.getAllMonthlyChallenge()
        }
        return monthlyChallenge
    }
    
    func getMonthlyChallengeProgress() -> [MonthlyChallengeProgress]? {
        return MonthlyChallengeDataRepository.shared.getMCPByUserID(userId: 0)
    }
    
    func getAllBadges() -> [Badge]?{
        return BadgeDataRepository.shared.getAllBadges()
    }
    
    //    func getTipsDetail() -> [SampahDetail]?{
    //        return TipsDataRepository.shared.getTipsDetailById(sampahId: Int(self.tips?.sampah_id ?? 0))
    //
    //    }
}
