//
//  PapahTests.swift
//  PapahTests
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//  swiftlint:disable all

import XCTest
import CoreData

@testable import Papah

class TipsRepositoryUnitTest: XCTestCase {
    var tipsRepo = TipsDataRepository.shared
    let entityName = Sampah.self.description()

    override func tearDown() {
        super.tearDown()
        tipsRepo.deleteAllTips()
    }
    
    func test_tipsInsertData() {
        
        let expectation = self.expectation(description: "Should return correct data")
        expectation.expectedFulfillmentCount = 1
        
        // when
        tipsRepo.insertTips(title: "test", desc: "test", sampahId: 1, image: UIImage.init())
        
        let data = tipsRepo.getAllTips()
        
        if let result = data?.first {
            XCTAssertEqual(result.title, "test")
            expectation.fulfill()
        } else {
            XCTFail("Should return proper response")
        }
        
        // then
        wait(for: [expectation], timeout: 5)
    }
    
    func test_tipsDetailInsertData() {
        
        let expectation = self.expectation(description: "Should return correct data")
        expectation.expectedFulfillmentCount = 1
        
        // when
        
//        let entity = NSEntityDescription.entity(forEntityName: entityName, in: CoreDataManager.sharedManager.persistentContainer.viewContext)
//        let challenges = SampahDetail(entity: entity!, insertInto: CoreDataManager.sharedManager.persistentContainer.viewContext)

        tipsRepo.insertTips(title: "test1", desc: "test", sampahId: 1, image: UIImage.init())
        tipsRepo.insertTipsDetail(title: "test2", detail: "test", sampahId: 1, sampahDetailId: 1, image: UIImage.init())
        
        let data = tipsRepo.getAllTips()
        
        if let result = data?.first, let tipsDetail = result.sampahDetail?.allObjects.first as? SampahDetail {
            XCTAssertEqual(result.title, "test1")
            XCTAssertEqual(tipsDetail.title, "test2")
            expectation.fulfill()
        } else {
            XCTFail("Should return proper response")
        }
        
        // then
        wait(for: [expectation], timeout: 5)
    }
}
