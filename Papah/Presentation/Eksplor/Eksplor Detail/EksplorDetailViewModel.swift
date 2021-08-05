//
//  EksplorDetailViewModel.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit
import CoreLocation
import Combine

class EksplorDetailViewModel {
    
    typealias Earnings = (wasteCategory:Int, berat:Float)

    var wbklData: Wbkl?
    var singleEarningData: [Earnings] = [Earnings]()
    
    var onClaimPointReady = CurrentValueSubject<Bool,Never>(false)
    var distanceMeter = 0.0
    var totalEarnings:Float = 0
    
    var wbklRepo = WbklDataRepository.shared
    var challengeRepo = MonthlyChallengeDataRepository.shared
    var badgeRepo = BadgeDataRepository.shared
    var userRepo = UserDataRepository.shared

    init(wbklData: Wbkl) {
        self.wbklData = wbklData
        initDataEarning()
        
        checkClaimPoint()
    }
    
    func initDataEarning() {
        if let data = getWasteAcceptedData() {
            for wasteData in data {
                self.singleEarningData.append(Earnings(Int(wasteData.wasteCategory?.waste_category_id ?? 0),0))
            }
        }
    }
    
    func checkClaimPoint(){
        
        var currentCondition = false
        
        let hour = Calendar.current.dateComponents([.hour], from:self.wbklData?.claimed_date ?? Date(), to: Date()+1000).hour ?? 0
        
        let isOpen = CommonFunction.shared.bukaTutupChecker(operationalDay: self.wbklData?.operational_day ?? "Senin", operationalHour: self.wbklData?.operational_hour ?? "10.00")
                
        if self.distanceMeter < Constants.claimPointDistance //First condition (location)
//            && hour > Constants.claimPointHours //Second condition (hour)
            && self.totalEarnings > 0 //Last condition (earning estimate)
//            && isOpen
        {
            currentCondition = true
        }
        
        self.onClaimPointReady.send(currentCondition)
        
    }
    
    func getWasteAcceptedData() -> [WasteAccepted]? {
        return self.wbklData?.wasteAccepted?.allObjects as? [WasteAccepted]
    }
    
    func distanceBetweenTwoLocations(source:CLLocation, destination:CLLocation) -> Double {
        
        let distanceMeters = source.distance(from: destination)
        print("USER distanceMeters \(distanceMeters)")

        let distanceKM = distanceMeters / 1000
        let roundedTwoDigit = distanceKM
        
        self.distanceMeter = distanceMeters
        self.checkClaimPoint()
        
        return roundedTwoDigit
        
    }
    
    func getEarningTotal() -> Float {
        totalEarnings = 0
        for (index, data) in self.singleEarningData.enumerated() {
            let totalSingleEarning = data.berat * Float(getWasteAcceptedData()?[index].price ?? 1)
            totalEarnings += totalSingleEarning
        }
        
        checkClaimPoint()
        
        return totalEarnings
    }
    
    func getWeightTotal() -> Float {
        var weightTotal: Float = 0
        for (_, data) in self.singleEarningData.enumerated() {
            weightTotal += data.berat
        }
        return weightTotal
    }
    
    func getCategoryUsedTotal() -> Float {
        var categoryUsedTotal: Float = 0
        for (_, data) in self.singleEarningData.enumerated() {
            if data.berat != 0 {
                categoryUsedTotal += 1
            }
        }
        return categoryUsedTotal
    }
    
    func getLocationDistance(userLocation: CLLocation) -> Double {
        
        if let wbklData = wbklData {
            
            print("WBKL LOC \(wbklData.latitude) : \(wbklData.longitude)")
            print("USER LOC \(userLocation.coordinate.latitude) : \(userLocation.coordinate.longitude)")
            
            let targetLocation = CLLocation(latitude:Double(wbklData.latitude), longitude: Double(wbklData.longitude))
            let userLocation = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            
            print("""
                user loc = \(userLocation)
                target loc = \(targetLocation)
                distance = \(distanceBetweenTwoLocations(source: targetLocation, destination: userLocation)) KM
                """)
            
            return distanceBetweenTwoLocations(source: targetLocation, destination: userLocation)
            
        }
        
        return 0
        
    }
    
    
    func onPointClaimed() {
        
        updateWBKLSection()
        updateChallengeSection()
        updateBadgeSection()
        updateUserSection()
        
    }
    
}

extension EksplorDetailViewModel {
    
    // MARK: User section
    func updateUserSection(){
        userRepo.updateTotalUang(userId: 0, income: Int(self.getEarningTotal()))
        UserDataRepository.shared.updatePoint(userId: 0, newPoint: Constants.claimPointWBKL)
    }
    
    // MARK: WBKL section
    func updateWBKLSection(){
        wbklRepo.updateWbklClaimDate(wbklId: Int(self.wbklData?.wbkl_id ?? 0), claimedDate: Date())
    }
    
    // MARK: Challenge section
    func updateChallengeSection(){
        
        if let monthlyChallengeProgress = challengeRepo.getAllMonthlyChallengeProgress() {
            
            for mcp in monthlyChallengeProgress {
                if !mcp.status && Int(mcp.monthlyChallenge?.month ?? 0) == Date().month {
                    // Berat Sampah
                    if Int(mcp.monthlyChallenge?.badgeCategory?.badge_category_id ?? 0) == 0 {
                        challengeRepo.updateMonthlyChallengeProgress(
                            mcpId: Int(mcp.mcp_id ),
                            value: self.getWeightTotal())
                    }
                    
                    // Profit
                    if Int(mcp.monthlyChallenge?.badgeCategory?.badge_category_id ?? 0) == 2 {
                        challengeRepo.updateMonthlyChallengeProgress(
                            mcpId: Int(mcp.mcp_id ),
                            value: self.getEarningTotal())
                    }
                    
                    // Kategori Sampah
                    if Int(mcp.monthlyChallenge?.badgeCategory?.badge_category_id ?? 0) == 3 {
                        challengeRepo.updateMonthlyChallengeProgress(
                            mcpId: Int(mcp.mcp_id ),
                            value: self.getCategoryUsedTotal())
                    }
                    
                    // Tantangan Sampah
                    if Int(mcp.monthlyChallenge?.badgeCategory?.badge_category_id ?? 0) == 4 {
                        // Tidak ada challenge progress yang berisi tantangan (tantangan ception?)
                    }
                    
                    // Agen
                    if Int(mcp.monthlyChallenge?.badgeCategory?.badge_category_id ?? 0) == 5 {
                        challengeRepo.updateMonthlyChallengeProgress(
                            mcpId: Int(mcp.mcp_id ),
                            value: 1)
                    }
                                        
                    // Level
                    if Int(mcp.monthlyChallenge?.badgeCategory?.badge_category_id ?? 0) == 1 {
                        challengeRepo.updateMonthlyChallengeProgress(
                            mcpId: Int(mcp.mcp_id ),
                            value: Float(userRepo.getUserById(id: 0)?.level ?? 0))
                        
                    }
                }
            }
            
        }
        
    }
    
    // MARK: Badge section
    func updateBadgeSection(){
        
        if let badgeProgress = badgeRepo.getAllBadgeProgress() {
            
            for badge in badgeProgress {
                if !badge.status  {
                    
                    print("SADSADDSA \(badge.badge?.badgeCategory?.badge_category_id)")
                    // Berat Sampah
                    if Int(badge.badge?.badgeCategory?.badge_category_id ?? 0) == 0 {
                        badgeRepo.updateBagdeProgress(bpId: Int(badge.bp_id), value: self.getWeightTotal())
                    }

                    // Profit
                    if Int(badge.badge?.badgeCategory?.badge_category_id ?? 0) == 2 {
                        badgeRepo.updateBagdeProgress(bpId: Int(badge.bp_id), value: self.getEarningTotal())
                    }

                    // Kategori Sampah
                    if Int(badge.badge?.badgeCategory?.badge_category_id ?? 0) == 3 {
                        badgeRepo.updateBagdeProgress(bpId: Int(badge.bp_id), value: self.getCategoryUsedTotal())
                    }

                    // Tantangan Sampah
                    if Int(badge.badge?.badgeCategory?.badge_category_id ?? 0) == 4 {
                        // Tidak ada challenge progress yang berisi tantangan (tantangan ception?)
                        if let monthlyChallengeCompleted = challengeRepo.getCurrentChallengeCompleted(month: Date().month) {
                            badgeRepo.updateBagdeProgress(bpId: Int(badge.bp_id), value: Float(monthlyChallengeCompleted.count))
                        }
                    }

                    // Agen
                    if Int(badge.badge?.badgeCategory?.badge_category_id ?? 0) == 5 {
                        badgeRepo.updateBagdeProgress(bpId: Int(badge.bp_id), value: 1)
                    }

                    // Level
                    if Int(badge.badge?.badgeCategory?.badge_category_id ?? 0) == 1 {
                        badgeRepo.updateBagdeProgress(
                            bpId: Int(badge.bp_id),
                            value: Float(userRepo.getUserById(id: 0)?.level ?? 0)
                        )

                    }
                }
            }
            
        }
        
    }
    
}
