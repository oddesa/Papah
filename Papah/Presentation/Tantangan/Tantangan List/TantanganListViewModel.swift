//
//  TantanganListViewModel.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

class TantanganListViewModel: NSObject {
    var user: User?
    var badges: Badge?
    var badgeProgress: [BadgeProgress]?
    
    func getUserData() -> User? {
        if user == nil {
            user = UserDataRepository.shared.getUserById(id: 0)
        }
        return user
    }
    
    func getMonthlyChallenge(currentMonth: Int) -> [MonthlyChallenge]? {
        return MonthlyChallengeDataRepository.shared.getMonthlyChallengebyMonth(currentMonth: currentMonth)
    }
    
    func getMonthlyChallengeProgress(currentMonth: Int) -> [MonthlyChallengeProgress]? {
        return MonthlyChallengeDataRepository.shared.getMCPByUserIdAndMonth(userId: 0, currentMonth: currentMonth)
    }
    
    func getAllBadgesProgress(userId: Int) -> [BadgeProgress]?{
        badgeProgress = BadgeDataRepository.shared.getBadgeProgressByUserId(userId: userId)
        return badgeProgress
    }
}
