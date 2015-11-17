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
    
    /** Whether or not the game is paused */
    private var isPaused: Bool
    
    /** The view of the card which hasn't yet landed on the table but is being flipped */
    private var nextCardView: CardView?
    
    /** The deck to be split between player */
    private var deck: Deck
    
    /** The stack of cards in the center of the table */
    private var centerStack: Stack
    
    /** The timer used between turns */
    private var turnTimer: NSTimer
    
    /** The last four card views placed on the table */
    private var lastFourCardViews: Array<CardView>
    
    /** The game table */
    private var gameTable: Table;
    
    /** The current seat of the player that is currently taking their turn */
    private var currentSeat: Seat!
    
    // Players
    private var northPlayer: Player
    private var eastPlayer: Player
    private var westPlayer: Player
    private var humanPlayer: Player
    
    
    // MARK: Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        deck = Deck()
        centerStack = Stack()
        turnTimer = NSTimer()
        isPaused = false
        
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
        
        setupSnapButton()
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
    
    private func setupSnapButton() {
        self.boardView.snapButton.addTarget(self, action: "snap", forControlEvents: .TouchUpInside)
    }
    
    
    // MARK: Game Start
    
    private func startGame() {
        currentSeat = gameTable.seatForPosition(humanPlayer.seatPosition)
        nextTurn()
    }
    
    
    // MARK: Snap
    
    func snap() {
        let cardCount = lastFourCardViews.count
        if (cardCount < 2) { return }
        
        pauseGame()
        
        let topCardView = lastFourCardViews[cardCount - 1]
        let lastCardView = lastFourCardViews[cardCount - 2]
        
        self.animateTopTwoCardsAwayFromDeck(topCardView, lastCardView: lastCardView) { completed in
            sleep(2)
            self.animateTopTwoCardsIntoDeck(topCardView, lastCardView: lastCardView) { completed in
                
                
            }
        }
    }
    
    func pauseGame() {
        isPaused = true
        
        let card = nextCardView?.card
        currentSeat.player?.cardStack.addCard(card)
        
        nextCardView?.card = nil
        nextCardView?.removeFromSuperview()
    }
    
    private func animateTopTwoCardsAwayFromDeck(topCardView:CardView, lastCardView:CardView, callback:SingleBoolCallback) {
        var topCardViewFrame = topCardView.frame
        topCardViewFrame.offsetInPlace(dx: -topCardViewFrame.width/4, dy: -topCardViewFrame.height/8)
        
        var lastCardViewFrame = lastCardView.frame
        lastCardViewFrame.offsetInPlace(dx: lastCardViewFrame.width/4, dy: -lastCardViewFrame.height/8)
        
        UIView.animateWithDuration(1, animations: {
            topCardView.frame = topCardViewFrame
            lastCardView.frame = lastCardViewFrame
        }) { completed in
            callback(completed)
        }
    }
    
    private func animateTopTwoCardsIntoDeck(topCardView:CardView, lastCardView:CardView, callback:SingleBoolCallback) {
        var topCardViewFrame = topCardView.frame
        topCardViewFrame.offsetInPlace(dx: topCardViewFrame.width/4, dy: topCardViewFrame.height/8)
        
        var lastCardViewFrame = lastCardView.frame
        lastCardViewFrame.offsetInPlace(dx: -lastCardViewFrame.width/4, dy: lastCardViewFrame.height/8)
        
        UIView.animateWithDuration(1, animations: {
            topCardView.frame = topCardViewFrame
            lastCardView.frame = lastCardViewFrame
            }) { completed in
                callback(completed)
        }
    }
    
    
    // MARK: Game Ticks
    
    func nextTurn() {
        self.turnTimer.invalidate()
        
        if (lastFourCardViews.count == 4) { removeOldestCardView() }
        if (centerStack.count == 52) { return } // DECK EMPTY
        
        if let nextPlayer = currentSeat.player {
            let card = nextPlayer.cardStack.getTopCard()
            let cardView = CardView(card: card)
            
            self.nextCardView = cardView;
            cardView.userInteractionEnabled = false
            
            self.presentCardView(cardView)
        }
        
        boardView.showPlayerInformationForSeat(currentSeat)
        currentSeat = gameTable.nextSeat(currentSeat)
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
            }) { completed in
                if (completed) {
                    self.lastFourCardViews.append(cardView)
                    self.centerStack.addCard(cardView.card)
                    
                    if (!self.isPaused) {
                        self.turnTimer = NSTimer(timeInterval: 0.2, target: self, selector: "nextTurn", userInfo: nil, repeats: true)
                        NSRunLoop.currentRunLoop().addTimer(self.turnTimer, forMode:NSRunLoopCommonModes)
                    }
                }
        }
        
        boardView.addSubview(cardView)
        cardView.flip(Table.flipDirectionForSeat(currentSeat))
    }
    
    private func removeOldestCardView() {
        let oldestCardView = lastFourCardViews.first!
        oldestCardView.removeFromSuperview()
        
        lastFourCardViews.removeFirst()
    }
    
}