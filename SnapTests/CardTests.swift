//
//  CardTests.swift
//  Snap
//
//  Created by Joey Clover on 11/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

import XCTest

class CardTests: XCTestCase {
  
  
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThatCardsRetainsSuitsAndValues() {
        let card = Card(suit: .Hearts, andValue: .Ace)
        let expectedCard = Card(suit: .Hearts, andValue: .Ace)
        
        XCTAssertEqual(card, expectedCard)
    }
    
}
