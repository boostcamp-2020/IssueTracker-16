//
//  IssueTrackerTests.swift
//  IssueTrackerTests
//
//  Created by 홍경표 on 2020/10/30.
//

import XCTest
@testable import IssueTracker

class IssueTrackerTests: XCTestCase {
    
    func testDateRegularExpression() throws {
        let valid = "2020-12-31"
        XCTAssertNotNil(valid.dateRegEx)
        XCTAssertEqual(valid, valid.dateRegEx)
        let invalidFormat = "20201231"
        XCTAssertNil(invalidFormat.dateRegEx)
        let invalidMonth = "2020-13-31"
        XCTAssertNil(invalidMonth.dateRegEx)
        let invalidDay = "2020-12-32"
        XCTAssertNil(invalidDay.dateRegEx)
    }
    
    func testUIColorHexString() throws {
        let redHex = "#FF0000"
        let red = UIColor(hex: redHex)
        XCTAssertEqual(red, UIColor.red)
        XCTAssertEqual(redHex, red?.hexString)
    }

}
