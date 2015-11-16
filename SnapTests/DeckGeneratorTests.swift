//
//  DeckGeneratorTests.swift
//  Snap
//
//  Created by Joey Clover on 16/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

import XCTest


class DeckGeneratorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThatSuitedDeckGeneratorWorks() {
        let deck = DeckGenerator.generateSuitedDeck()
        
        XCTAssertTrue(deck.cards.count == 52)
        
        let topCard = deck.getTopCard()
        let isSuitedCard = topCard is SuitedCard
        
        XCTAssertTrue(isSuitedCard)
    }
    
}
