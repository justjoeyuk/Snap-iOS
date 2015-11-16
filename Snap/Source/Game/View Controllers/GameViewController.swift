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
    var snapTimer: NSTimer
    var lastFourCardViews: Array<CardView> = []
    
    var botPlayer: Player;
    var humanPlayer: Player;
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        deck = DeckGenerator.generateSuitedDeck()
        snapTimer = NSTimer()
        
        botPlayer = Player(name: "Rowan Bot", cardStack: nil)
        humanPlayer = Player(name: "Me", cardStack:nil)
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    override func loadView() {
        self.view = BoardView()
    }
    
    override func viewDidAppear(animated: Bool) {
        snapTimer = NSTimer(timeInterval: 1, target: self, selector: "turnCard", userInfo: nil, repeats: true)
        
        turnCard()
        NSRunLoop.currentRunLoop().addTimer(snapTimer, forMode:NSRunLoopCommonModes)
    }
    
    override func setup() {
        deck.shuffleCards()
        let stacks: Array<Stack> = deck.split(2)
        
        humanPlayer.cardStack = stacks[0];
        botPlayer.cardStack = stacks[1];
        
        print("Human \(humanPlayer.cardStack.cards.count) --- Bot \(botPlayer.cardStack.cards.count)")
        
        humanPlayer.cardStack.addStack(botPlayer.cardStack)
        
        print("Human \(humanPlayer.cardStack.cards.count) --- Bot \(botPlayer.cardStack.cards.count)")
    }
    
    func turnCard() {
        if (lastFourCardViews.count == 4) { removeOldestCardView() }
        if (humanPlayer.cardStack.count == 0) { return } // DECK EMPTY
        
        let card = humanPlayer.cardStack.getTopCard()
        let cardView = CardView(card: card)
        self.presentCardView(cardView)
        
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
        
        cardView.frame = CGRect(x: (self.view.center.x-initialWidth/2), y:-initialHeight, width: initialWidth, height: initialHeight)
        let endFrame = CGRect(x: (self.view.center.x-width/2), y: 100, width: width, height: height)
        
        UIView.animateWithDuration(0.8, animations: {
            cardView.frame = endFrame
        })
        
        boardView.addSubview(cardView)
        lastFourCardViews.append(cardView)
        
        cardView.flip(.FromBottom)
    }
    
}