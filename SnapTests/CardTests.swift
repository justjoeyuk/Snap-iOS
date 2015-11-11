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
        let card = SuitedCard(suit: .Hearts, andValue: .Ace)
        let expectedCard = SuitedCard(suit: .Hearts, andValue: .Ace)
        
        XCTAssertEqual(card, expectedCard)
    }
    
    func testThatSuitedCardsDisplayCorrectly() {
        let aceOfHearts = SuitedCard(suit: .Hearts, andValue: .Ace)
        let jackOfDiamonds = SuitedCard(suit: .Diamonds, andValue: .Jack)
        let queenOfClubs = SuitedCard(suit: .Clubs, andValue: .Queen)
        let kingOfSpades = SuitedCard(suit: .Spades, andValue: .King)
        
        let view = SuitedCardView(card: aceOfHearts)
        
        XCTAssertEqual(view.suitCharacter, "♥")
        XCTAssertEqual(view.valueText, "A")
        
        view.card = jackOfDiamonds
        XCTAssertEqual(view.suitCharacter, "♦")
        XCTAssertEqual(view.valueText, "J")
        
        view.card = queenOfClubs
        XCTAssertEqual(view.suitCharacter, "♣")
        XCTAssertEqual(view.valueText, "Q")
        
        view.card = kingOfSpades
        XCTAssertEqual(view.suitCharacter, "♠")
        XCTAssertEqual(view.valueText, "K")
    }
    
}
