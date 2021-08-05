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
    
    func getUserData() -> User? {
        if user == nil {
            user = UserDataRepository.shared.getUserById(id: 0)
        }
        return user
    }
    
    func getMonthlyChallengeProgress(currentMonth: Int) -> [MonthlyChallengeProgress]? {
        return MonthlyChallengeDataRepository.shared.getMCPByUserIdAndMonth(userId: 0, currentMonth: currentMonth)
    }
    
    func getAllBadges() -> [Badge]?{
        //sort by status == true
        return BadgeDataRepository.shared.getAllBadges()
    }
}
