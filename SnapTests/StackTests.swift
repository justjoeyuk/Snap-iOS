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
    
    func testThatTopCardWorks() {
        let stack = Stack()
        
        let one = SuitedCard()
        let two = SuitedCard()
        stack.addCard(one)
        stack.addCard(two)
        
        let topCard = stack.getTopCard() as! SuitedCard
        
        XCTAssertEqual(topCard, two)
    }
    
    func testThatStackCanAddCards() {
        let stack = Stack()
        let cardOne = SuitedCard(suit: .Hearts, andValue: .Ace)
        let cardTwo = SuitedCard(suit: .Clubs, andValue: .Ace)
        
        stack.addCard(cardOne)
        stack.addCard(cardTwo)
        
        XCTAssertEqual(stack.cards.count, 2)
    }
    
    func testThatStacksCanAddStacks() {
        let cardOne = SuitedCard(suit: .Hearts, andValue: .Ace)
        let cardTwo = SuitedCard(suit: .Clubs, andValue: .Ace)
        
        let stack = Stack()
        stack.addCard(cardOne)
        
        let otherStack = Stack()
        otherStack.addCard(cardTwo)
        
        XCTAssertTrue(stack.cards.count == 1)
        XCTAssertTrue(otherStack.cards.count == 1)
        
        stack.addStack(otherStack)
        
        XCTAssertTrue(stack.cards.count == 2)
        XCTAssertTrue(otherStack.cards.count == 0)
    }

}
