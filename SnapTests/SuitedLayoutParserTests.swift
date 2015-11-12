//
//  SuitedLayoutParserTests.swift
//  Snap
//
//  Created by Joey Clover on 12/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

import XCTest

class SuitedLayoutParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThatSuitedLayoutParserCanParsePositionsCorrectly() {
        let ace = "----------x----------"
        let two = "-x-----------------x-"
        let three = "-x--------x--------x-"
        let delimeter = "#########"
        let threeSet = "\(ace)\(delimeter)\(two)\(delimeter)\(three)"
        
        let layouts = try! SuitedLayoutParser.parseString(threeSet)
        let twoValue = SuitedCardValue(rawValue: 2)!
        let threeValue = SuitedCardValue(rawValue: 3)!
        
        let aceExists = SuitedLayoutParser.suitExistsForValue(.Ace, atPosition: 10, forLayouts: layouts)
        
        let twoExists =  SuitedLayoutParser.suitExistsForValue(twoValue, atPosition: 1, forLayouts: layouts) &&
            SuitedLayoutParser.suitExistsForValue(twoValue, atPosition: 19, forLayouts: layouts)
        
        let threeExists = SuitedLayoutParser.suitExistsForValue(threeValue, atPosition: 1, forLayouts: layouts) &&
            SuitedLayoutParser.suitExistsForValue(threeValue, atPosition: 19, forLayouts: layouts) &&
            SuitedLayoutParser.suitExistsForValue(threeValue, atPosition: 10, forLayouts: layouts)
        
        XCTAssertTrue(aceExists, "Ace should have a suit at position 10")
        XCTAssertTrue(twoExists, "Two should have a suit at position 1 and 19")
        XCTAssertTrue(threeExists, "Three should have a suit at position 1, 19 and 10")
    }
    
    func testThatSuitedLayoutParserCanParseValidFile() {
        let layoutFile = NSBundle.mainBundle().pathForResource("suited_card_layouts", ofType: "txt")
        
        do {
            try SuitedLayoutParser.parseLayoutFile(layoutFile)
            XCTAssertTrue(true)
        }
        catch let error as NSError {
            XCTAssertTrue(false, "Parser should not throw error upon handling a valid file. \(error.domain) - \(error.code)")
        }
        
    }
    
    func testThatSuitedLayoutParserCanHandleInvalidFiles() {
        let bundle = NSBundle(forClass: SuitedLayoutParserTests.self)
        let notEnoughChars = bundle.pathForResource("suited_card_layouts_not_enough_chars", ofType: "txt")
        let tooManyChars = bundle.pathForResource("suited_card_layouts_too_many_chars", ofType: "txt")
        
        do {
            try SuitedLayoutParser.parseLayoutFile(notEnoughChars)
            try SuitedLayoutParser.parseLayoutFile(tooManyChars)
            
            XCTAssertFalse(true, "Should throw errors on invalid files")
        }
        catch let error as NSError {
            XCTAssertTrue(true, "Should be able to handle invalid files. Error: \(error.domain) - \(error.code)")
        }
    }
    
}
