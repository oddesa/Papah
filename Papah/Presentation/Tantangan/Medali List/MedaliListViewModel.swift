//
//  MedaliListViewModel.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

class MedaliListViewModel: NSObject {
    
    var badgeProgress: [BadgeProgress]?
    var badges: [Badge]?

    init(badges: [BadgeProgress]) {
        badgeProgress = badges
    }
    
    func getBadgeProgressData() -> [BadgeProgress]{
        return badgeProgress ?? []
    }
    
    func getBadgeData(index: Int) -> Badge?{
        let data = badgeProgress?[index].badge ?? nil
        return data
    }
    
}
