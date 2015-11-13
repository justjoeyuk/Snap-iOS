//
//  SuitedDeckTests.swift
//  Snap
//
//  Created by Joey Clover on 13/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

import XCTest

class SuitedDeckTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testThatShuffleWorks() {
        let deck = SuitedDeck()
        deck.fillWithCards()
        
        let originalDeck = deck.copy() as! SuitedDeck
        deck.shuffleCards()
        
        XCTAssertNotEqual(deck, originalDeck)
    }
    
    func testThatTopCardWorks() {
        let deck = SuitedDeck()
        deck.fillWithCards()
        
        let expectedCard = SuitedCard(suit: .Clubs, andValue: .King)
        let card = deck.getTopCard() as! SuitedCard
        
        XCTAssertEqual(card, expectedCard)
    }

}
