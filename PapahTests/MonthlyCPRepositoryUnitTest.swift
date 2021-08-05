//
//  PapahTests.swift
//  PapahTests
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//  swiftlint:disable all

import XCTest
import CoreData

@testable import Papah

class MonthlyCPRepositoryUnitTest: XCTestCase {
    var monthlyChallengeRepo = MonthlyChallengeDataRepository.shared

    override func tearDown() {
        super.tearDown()
    }
    
    override func setUp() {
        CoreDataManager.sharedManager.setContainer(container: CoreDataManagerUniTest.mockContainer())
    }
    
    func test_getAllMCP() {
        let expectation = self.expectation(description: "Should return correct data")
        expectation.expectedFulfillmentCount = 1
        
        // when
        
        
        MonthlyChallengeDataRepository.shared.insertMonthlyChallenge(
            userId: 0,
            badgeCategoryId: 5,
            mcId: 0,
            title: "Turis Sampah",
            desc: "Salurkan limbah & klaim poin ke 1 agen",
            month: Date().month,
            rewardPoint: 300,
            maxValue: 1,
            image: UIImage()
        )
        
        MonthlyChallengeDataRepository.shared.insertMonthlyChallengeProgress(
            userId: 0,
            mcId: 0,
            mcpId: 0,
            status: false,
            currentValue: 0
        )
        
        let data = monthlyChallengeRepo.getAllMonthlyChallengeProgress()
        
        
        if let result = data?.first {
            XCTAssertEqual(result.monthlyChallenge?.desc, "Salurkan limbah & klaim poin ke 1 agen")
            expectation.fulfill()
        } else {
            XCTFail("Should return proper response")
        }
        
        // then
        wait(for: [expectation], timeout: 5)
    }
}
