//
//  GameViewController.swift
//  Snap
//
//  Created by Joey Clover on 11/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

import Foundation
import UIKit


class GameViewController: BaseViewController {
    
    var boardView: BoardView { return self.view as! BoardView }
    
    
    var deck: Deck
    var centerStack: Stack
    var gameTimer: NSTimer
    var lastFourCardViews: Array<CardView>
    
    var gameTable: Table;
    var currentSeat: Seat!
    
    var northPlayer: Player
    var eastPlayer: Player
    var westPlayer: Player
    var humanPlayer: Player
    
    
    // MARK: Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        deck = Deck()
        centerStack = Stack()
        gameTimer = NSTimer()
        
        northPlayer = Player(name: "North Bot", cardStack: nil)
        westPlayer = Player(name: "West Bot", cardStack: nil)
        eastPlayer = Player(name: "East Bot", cardStack: nil)
        humanPlayer = Player(name: "Me", cardStack:nil)
        
        lastFourCardViews = []
        gameTable = Table()
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func loadView() {
        self.view = BoardView()
    }
    
    override func viewDidAppear(animated: Bool) {
        startGame()
    }
    
    
    // MARK: Setup
    
    override func setup() {
        setupDeck()
        setupPlayers()
        setupSeats()
    }
    
    private func setupPlayers() {
        let stacks: Array<Stack> = deck.split(4)
        
        humanPlayer.cardStack = stacks[0];
        northPlayer.cardStack = stacks[1];
        eastPlayer.cardStack = stacks[2];
        westPlayer.cardStack = stacks[3];
    }
    
    private func setupSeats() {
        let southSeat = Seat(player: humanPlayer, atPosition: .South)
        let northSeat = Seat(player: northPlayer, atPosition: .North)
        let eastSeat = Seat(player: eastPlayer, atPosition: .East)
        let westSeat = Seat(player: westPlayer, atPosition: .West)
        
        gameTable.addSeat(southSeat)
        gameTable.addSeat(northSeat)
        gameTable.addSeat(westSeat)
        gameTable.addSeat(eastSeat)
    }
    
    private func setupDeck() {
        deck = DeckGenerator.generateSuitedDeck()
        deck.shuffleCards()
    }
    
    
    // MARK: Game Start
    
    private func startGame() {
        currentSeat = gameTable.seatForPosition(humanPlayer.seatPosition)
        
        nextTurn()
        
        gameTimer = NSTimer(timeInterval: 0.8, target: self, selector: "nextTurn", userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(gameTimer, forMode:NSRunLoopCommonModes)
    }
    
    
    
    // MARK: Game Ticks
    
    private func nextTurn() {
        if (lastFourCardViews.count == 4) { removeOldestCardView() }
        if (centerStack.count == 52) { return } // DECK EMPTY
        
        if let nextPlayer = currentSeat.player {
            let card = nextPlayer.cardStack.getTopCard()
            let cardView = CardView(card: card)
            
            cardView.userInteractionEnabled = false
            
            self.presentCardView(cardView)
            centerStack.addCard(card)
        }
        
        boardView.showPlayerInformationForSeat(currentSeat)
        currentSeat = gameTable.nextSeat(currentSeat)
    }
    
    private func removeOldestCardView() {
        let oldestCardView = lastFourCardViews.first!
        oldestCardView.removeFromSuperview()
        
        lastFourCardViews.removeFirst()
    }
    
    private func presentCardView(cardView:CardView) {
        let initialWidth = UIScreen.mainScreen().bounds.width / 1.5
        let initialHeight = initialWidth / 0.7
        
        let width = UIScreen.mainScreen().bounds.width / 2
        let height = width / 0.7
        
        cardView.frame = Table.initialFrameForCardWithWidth(initialWidth, cardHeight: initialHeight, atSeat: currentSeat)
        let endFrame = CGRect(x: (self.view.center.x-width/2), y: 100, width: width, height: height)
        
        UIView.animateWithDuration(0.8, animations: {
            cardView.frame = endFrame
        })
        
        boardView.addSubview(cardView)
        lastFourCardViews.append(cardView)
        
        cardView.flip(Table.flipDirectionForSeat(currentSeat))
    }
    
}