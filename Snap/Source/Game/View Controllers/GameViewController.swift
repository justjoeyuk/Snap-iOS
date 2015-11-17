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
        isPaused = false
        
        northPlayer = Player(name: "Mike", cardStack: nil)
        westPlayer = Player(name: "Kate", cardStack: nil)
        eastPlayer = Player(name: "Michelle", cardStack: nil)
        humanPlayer = Player(name: "You", cardStack:nil)
        
        lastFourCardViews = []
        gameTable = Table()
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func loadView() {
        self.view = BoardView()
    }
    
    
    // MARK: Setup
    
    override func setup() {
        setupSeats()
        setupSnapButton()
        setupPlayButton()
    }
    
    private func setupSeats() {
        // I would have made this more efficient but time was short
        let southSeat = Seat(player: humanPlayer, atPosition: .South)
        let northSeat = Seat(player: northPlayer, atPosition: .North)
        let eastSeat = Seat(player: eastPlayer, atPosition: .East)
        let westSeat = Seat(player: westPlayer, atPosition: .West)
        
        let seats: Array<Seat> = [southSeat, northSeat, eastSeat, westSeat]
        
        boardView.updatePlayerInformationForSeats(seats)
        gameTable.addSeats(seats)
    }
    
    private func setupSnapButton() {
        self.boardView.snapButton.addTarget(self, action: "snap", forControlEvents: .TouchUpInside)
    }
    
    private func setupPlayButton() {
        self.boardView.playButton.addTarget(self, action: "startGame", forControlEvents: .TouchUpInside)
    }
    
    private func setupPlayers() {
        deck = DeckGenerator.generateSuitedDeck()
        deck.shuffleCards()
        
        let stacks: Array<Stack> = deck.split(4)
        
        humanPlayer.cardStack = stacks[0];
        northPlayer.cardStack = stacks[1];
        eastPlayer.cardStack = stacks[2];
        westPlayer.cardStack = stacks[3];
        
        boardView.updatePlayerInformationForSeats(gameTable.seats.allValues as! [Seat])
    }
    
    
    // MARK: Game Start
    
    func startGame() {
        currentSeat = gameTable.seatForPosition(eastPlayer.seatPosition)
        boardView.showSnapButton()
        
        setupPlayers()
        clearTable()
        
        nextTurn()
    }
    
    func stopGame(message:String) {
        UIAlertView(title: "Game Over", message: message, delegate: nil, cancelButtonTitle: "Ok").show()
        
        self.clearTable()
        self.boardView.showPlayButton()
    }
    
    private func clearTable() {
        lastFourCardViews.forEach { view in view.removeFromSuperview() }
        lastFourCardViews.removeAll()
    }
    
    
    // MARK: Snap
    
    func snap() {
        callSnap(humanPlayer)
    }
    
    private func callBotSnaps() {
        let bots = [northPlayer, westPlayer, eastPlayer]
        
        bots.forEach() { bot in
            let range = 0.7 - 0.2;
            let val = (Float(arc4random()) / Float(UINT32_MAX)) * Float(range) + 0.3;
            
            print("BOT VAL: \(val)")
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(val * Float(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
                self.callSnap(bot)
            }
        }
    }
    
    private func callSnap(player:Player) {
        if (lastFourCardViews.count < 2 || isPaused) { return }
        
        UIAlertView(title: "Snap!", message: "\(player.name) Snapped!", delegate: nil, cancelButtonTitle: "Ok").show()
        pauseGame()
        
        let topCardView = lastFourCardViews.last!
        let lastCardView = lastFourCardViews[lastFourCardViews.count - 2]
        
        self.animateTopTwoCardsAwayFromDeck(topCardView, lastCardView: lastCardView) { completed in
            sleep(1)
            self.animateTopTwoCardsIntoDeck(topCardView, lastCardView: lastCardView) { completed in
                sleep(1)
                
                if self.compareTopCards() {
                    self.validSnap(player)
                }
                else {
                    self.invalidSnap()
                }
            }
        }
    }
    
    private func validSnap( player:Player ) {
        let seat = gameTable.seatForPosition(player.seatPosition)
        
        player.cardStack.addStack(centerStack)
        boardView.updatePlayerInformationForSeat(seat)
        
        print("Snap! \(player.name) has \(player.cardStack.count) cards.")
        if (player.cardStack.count == deck.capacity) {
            self.stopGame("\(player.name) Won!")
        }
        else {
            self.clearTable()
            nextTurn()
        }
    }
    
    private func invalidSnap() {
        nextTurn()
    }
    
    private func compareTopCards() -> Bool {
        if (lastFourCardViews.count < 2) { return false }
        
        let topCardView = lastFourCardViews.last!
        let lastCardView = lastFourCardViews[lastFourCardViews.count - 2]
        
        let topCard = topCardView.card
        let lastCard = lastCardView.card
        
        return topCard?.numericIdentifier() == lastCard?.numericIdentifier()
    }
    
    
    // MARK: Pause
    
    func pauseGame() {
        isPaused = true
        
        if let card = nextCardView?.card {
            currentSeat.player?.cardStack.addCard(card)
            currentSeat = gameTable.previousSeat(currentSeat)
            
            nextCardView?.card = nil
            nextCardView?.removeFromSuperview()
        }
    }
    
    private func animateTopTwoCardsAwayFromDeck(topCardView:CardView, lastCardView:CardView, callback:SingleBoolCallback) {
        var topCardViewFrame = topCardView.frame
        topCardViewFrame.offsetInPlace(dx: -topCardViewFrame.width/4, dy: -topCardViewFrame.height/8)
        
        var lastCardViewFrame = lastCardView.frame
        lastCardViewFrame.offsetInPlace(dx: lastCardViewFrame.width/4, dy: -lastCardViewFrame.height/8)
        
        UIView.animateWithDuration(0.4, animations: {
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
        
        UIView.animateWithDuration(0.4, animations: {
            topCardView.frame = topCardViewFrame
            lastCardView.frame = lastCardViewFrame
            }) { completed in
                callback(completed)
        }
    }
    
    
    // MARK: Game Ticks
    
    func nextTurn() {
        if (lastFourCardViews.count == 4) { removeOldestCardView() }
        if (centerStack.count == deck.capacity) { stopGame("Draw. No Cards Left!"); return; }
        
        let lastSeat = currentSeat
        boardView.updatePlayerInformationForSeat(lastSeat)
        currentSeat = gameTable.nextSeat(currentSeat)
        
        self.isPaused = false
        
        if let currentPlayer = currentSeat.player {
            if currentPlayer.cardStack.count != 0 {
                let card = currentPlayer.cardStack.getTopCard()
                let cardView = CardView(card: card)
                
                self.nextCardView = cardView;
                self.presentCardView(cardView, fromSeat:currentSeat)
            }
            else {
                nextTurn()
            }
        }
    }
    
    private func presentCardView(cardView:CardView, fromSeat:Seat) {
        let cardWidth = UIScreen.mainScreen().bounds.width / 2
        let cardHeight = cardWidth / 0.7
        
        cardView.frame = Table.initialFrameForCardWithWidth(cardWidth * 0.7, cardHeight: cardHeight * 0.7, atSeat: currentSeat)
        let endFrame = CGRect(x: (self.view.center.x-cardWidth/2), y: 100, width: cardWidth, height: cardHeight)
        
        UIView.animateWithDuration(0.8, animations: {
            cardView.frame = endFrame
            }) { completed in
                if !completed { return }
                
                if !self.isPaused {
                    
                    self.addCardViewToCenterStack(cardView)
                    self.boardView.updatePlayerInformationForSeats(self.gameTable.seats.allValues as! [Seat])
                    
                    if self.compareTopCards() {
                        self.callBotSnaps()
                    }
                    
                    self.nextTurn()
                }
        }
        boardView.addSubview(cardView)
        
        let flipDirection = Table.flipDirectionForSeat(fromSeat)
        cardView.flip(flipDirection)
    }
    
    private func addCardViewToCenterStack(cardView:CardView) {
        self.lastFourCardViews.append(cardView)
        self.centerStack.addCard(cardView.card)
    }
    
    private func removeOldestCardView() {
        let oldestCardView = lastFourCardViews.first!
        oldestCardView.removeFromSuperview()
        
        lastFourCardViews.removeFirst()
    }
    
}