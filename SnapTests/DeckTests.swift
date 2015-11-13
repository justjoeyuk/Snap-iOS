//
//  DeckTests.swift
//  Snap
//
//  Created by Joey Clover on 11/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

import XCTest

class DeckTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThatDeckCanAddCards() {
        let deck = Deck()
        let cardOne = SuitedCard(suit: .Hearts, andValue: .Ace)
        let cardTwo = SuitedCard(suit: .Clubs, andValue: .Ace)
        
        deck.addCard(cardOne)
        deck.addCard(cardTwo)
        
        XCTAssertEqual(deck.cards.count, 2)
    }
    
}
