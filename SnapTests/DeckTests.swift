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
    
    func testThatRemoveAllCardsWorks() {
        let deck = DeckGenerator.generateSuitedDeck()
        
        XCTAssertTrue(deck.cards.count == 52)
        
        deck.removeAllCards()
        
        XCTAssertTrue(deck.cards.count == 0)
    }
    
    func testThatShuffleWorks() {
        let deck = DeckGenerator.generateSuitedDeck()
        
        let originalCards = deck.cards.copy() as! NSArray
        deck.shuffleCards()
        
        XCTAssertNotEqual(deck.cards, originalCards)
    }
    
}
