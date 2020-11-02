//
//  IssueTrackerTests.swift
//  IssueTrackerTests
//
//  Created by 홍경표 on 2020/10/30.
//

import XCTest
@testable import IssueTracker

class IssueTrackerTests: XCTestCase {
    
    // MARK: - Regular Expression
    
    func test_regularExpression_withValidDate_shouldNotBeNil() throws {
        let valid = "2020-12-31"
        XCTAssertNotNil(valid.dateRegEx)
        XCTAssertEqual(valid, valid.dateRegEx)
    }
    
    func test_regularExpression_withInvalidDate_shouldBeNil() throws {
        let invalidFormat = "20201231"
        XCTAssertNil(invalidFormat.dateRegEx)
        let invalidMonth = "2020-13-31"
        XCTAssertNil(invalidMonth.dateRegEx)
        let invalidDay = "2020-12-32"
        XCTAssertNil(invalidDay.dateRegEx)
    }
    
    // MARK: - UIColor+String
    
    func test_UIColorToHexString_withRGBColorNotGrayScale() throws {
        let redHex = UIColor.red.hexString
        XCTAssertEqual(redHex, "#FF0000")
        let blueHex = UIColor.blue.hexString
        XCTAssertEqual(blueHex, "#0000FF")
        let blackHex = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1).hexString
        XCTAssertEqual(blackHex, "#000000")
    }
    
    func test_hexStringToUIColor_withValidString() throws {
        let redHex = "#FF0000"
        XCTAssertEqual(UIColor.init(hex: redHex), UIColor.red)
        let blueHex = "#0000FF"
        XCTAssertEqual(UIColor.init(hex: blueHex), UIColor.blue)
        let blackHex = "#000000"
        XCTAssertEqual(UIColor.init(hex: blackHex), UIColor.init(red: 0, green: 0, blue: 0, alpha: 1))
    }
    
    func test_hexStringToUIColor_withInvalidString_shouldBeNil() throws {
        let invalidHex1 = "#FF00000"
        let invalid1 = UIColor(hex: invalidHex1)
        XCTAssertNil(invalid1)
        let invalidHex2 = "0000000"
        let invalid2 = UIColor(hex: invalidHex2)
        XCTAssertNil(invalid2)
    }

}
