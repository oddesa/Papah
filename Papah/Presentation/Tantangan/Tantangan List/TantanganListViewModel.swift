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
    var mc: MonthlyChallenge?
    var badges: Badge?
    
    func getUserData() -> User? {
        if user == nil {
            user = UserDataRepository.shared.getUserById(id: 0)
        }
        return user
    }
    
    func getMonthlyChallenge(currentMonth: Int) -> [MonthlyChallenge]? {
        if monthlyChallenge == nil {
            monthlyChallenge = MonthlyChallengeDataRepository.shared.getMonthlyChallengebyMonth(currentMonth: currentMonth)
        }
        
        return monthlyChallenge
    }
    
    func getMonthlyChallengeProgress() -> [MonthlyChallengeProgress]? {
        //panggil relation dari monthlychallenge aja
        return MonthlyChallengeDataRepository.shared.getMCPByUserID(userId: 0)
        //return self.mc?.monthlyCP?.allObjects as? [MonthlyChallengeProgress]
    }
    
    func getAllBadges() -> [Badge]?{
        //sort by status == true
        return BadgeDataRepository.shared.getAllBadges()
    }
}
