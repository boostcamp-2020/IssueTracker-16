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
        let blueHex = "0000FF"
        let blue = UIColor(hex: blueHex)
        XCTAssertEqual(blue, UIColor.blue)
        XCTAssertEqual("#" + blueHex, blue?.hexString)
        let blackHex = "000000"
        let black = UIColor(hex: blackHex)
        XCTAssertEqual(black, UIColor.init(red: 0, green: 0, blue: 0, alpha: 1))
        XCTAssertEqual("#" + blackHex, black?.hexString)
        let invalidHex1 = "#FF00000"
        let invalid1 = UIColor(hex: invalidHex1)
        XCTAssertNil(invalid1)
        let invalidHex2 = "0000000"
        let invalid2 = UIColor(hex: invalidHex2)
        XCTAssertNil(invalid2)
    }

}
