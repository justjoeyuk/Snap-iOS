//
//  SuitedCardTests.swift
//  Snap
//
//  Created by Joey Clover on 12/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//
import XCTest


class SuitedCardTests: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThatSuitedCardsRetainsSuitsAndValues() {
        let card = SuitedCard(suit: .Hearts, andValue: .Ace)
        let expectedCard = SuitedCard(suit: .Hearts, andValue: .Ace)
        
        XCTAssertEqual(card, expectedCard)
    }
    
    func testThatSuitedCardsDisplayCorrectly() {
        let aceOfHearts = SuitedCard(suit: .Hearts, andValue: .Ace)
        let jackOfDiamonds = SuitedCard(suit: .Diamonds, andValue: .Jack)
        let queenOfClubs = SuitedCard(suit: .Clubs, andValue: .Queen)
        let kingOfSpades = SuitedCard(suit: .Spades, andValue: .King)
        
        let view = CardView(card: aceOfHearts)
        let frontFaceView = view.frontView as! SuitedCardFrontView
        
        XCTAssertEqual(frontFaceView.suitCharacter, "♥")
        XCTAssertEqual(frontFaceView.valueText, "A")
        
        view.card = jackOfDiamonds
        XCTAssertEqual(frontFaceView.suitCharacter, "♦")
        XCTAssertEqual(frontFaceView.valueText, "J")
        
        view.card = queenOfClubs
        XCTAssertEqual(frontFaceView.suitCharacter, "♣")
        XCTAssertEqual(frontFaceView.valueText, "Q")
        
        view.card = kingOfSpades
        XCTAssertEqual(frontFaceView.suitCharacter, "♠")
        XCTAssertEqual(frontFaceView.valueText, "K")
    }
    
    func testThatSuitedCardsFlipCorrectly() {
        let card = SuitedCard(suit: .Hearts, andValue: .Ace)
        let cardView = CardView(card: card, initialFace: .Front)
        
        XCTAssertEqual(cardView.face, .Front)
        
        cardView.flip()
        
        XCTAssertEqual(cardView.face, .Back)
        
        cardView.flip()
        
        XCTAssertEqual(cardView.face, .Front)
    }
    
}
