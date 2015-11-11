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
        let cardOne = Card(suit: .Hearts, andValue: .Ace)
        let cardTwo = Card(suit: .Clubs, andValue: .Ace)
        
        deck.addCard(cardOne)
        deck.addCard(cardTwo)
        
        XCTAssertEqual(deck.cards.count, 2)
    }
    
    func testThatShuffleWorks() {
        let deck = Deck()
        deck.fillWithCards()
        
        let originalDeck = deck.copy() as! Deck
        deck.shuffleCards()
        
        XCTAssertNotEqual(deck, originalDeck)
    }
    
}
