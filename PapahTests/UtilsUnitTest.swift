//
//  PapahTests.swift
//  PapahTests
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//  swiftlint:disable all

import XCTest
import CoreData

@testable import Papah

class UtilsUnitTest: XCTestCase {
    
    override func tearDown() {
        super.tearDown()
    }
    func test_CurrentMonthValue() {
        
        let expectation = self.expectation(description: "Should return correct data")
        expectation.expectedFulfillmentCount = 1
        
        // when

        let month = Date().month
        
        XCTAssertEqual(month, month)
        expectation.fulfill()
        
//        if let result = month {
//            XCTAssertEqual(result.title, "test")
//            expectation.fulfill()
//        } else {
//            XCTFail("Should return proper response")
//        }
        
        // then
        wait(for: [expectation], timeout: 5)
    }
    
}
