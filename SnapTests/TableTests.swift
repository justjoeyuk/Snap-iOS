//
//  TableTests.swift
//  Snap
//
//  Created by Joey Clover on 16/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

import XCTest

class TableTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThatTableRetrievesNextSeatCorrectly() {
        
        let player = Player(name: "Test", cardStack: nil)
        let table = Table()
        
        let northSeat = Seat(player: player, atPosition: .North)
        let southSeat = Seat(player: player, atPosition: .South)
        let eastSeat = Seat(player: player, atPosition: .East)
        let westSeat = Seat(player: player, atPosition: .West)
        
        table.addSeat(northSeat)
        table.addSeat(westSeat)
        table.addSeat(southSeat)
        table.addSeat(eastSeat)
        
        XCTAssertEqual(table.nextSeat(northSeat), eastSeat)
        XCTAssertEqual(table.nextSeat(eastSeat), southSeat)
        XCTAssertEqual(table.nextSeat(southSeat), westSeat)
        XCTAssertEqual(table.nextSeat(westSeat), northSeat)
        
        table.removeSeatFromPosition(.East)
        
        XCTAssertEqual(table.nextSeat(northSeat), southSeat)
        
        table.removeSeatFromPosition(.South)
        
        XCTAssertEqual(table.nextSeat(northSeat), westSeat)
        
        table.removeSeatFromPosition(.West)
        
        XCTAssertEqual(table.nextSeat(northSeat), northSeat)
        
        table.removeSeatFromPosition(.North)
        
        XCTAssertNil(table.nextSeat(northSeat))
    }
    
}