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
    var deck: SuitedDeck
    var snapTimer: NSTimer
    var arr: Array<SuitedCardView> = []
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        deck = SuitedDeck()
        snapTimer = NSTimer()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    override func loadView() {
        self.view = BoardView()
    }
    
    override func viewDidAppear(animated: Bool) {
        snapTimer = NSTimer(timeInterval: 4, target: self, selector: "turnCard", userInfo: nil, repeats: true)
        
        turnCard()
        NSRunLoop.currentRunLoop().addTimer(snapTimer, forMode:NSRunLoopCommonModes)
    }
    
    override func setup() {
        deck.fillWithCards()
        deck.shuffleCards()
    }
    
    func turnCard() {
        let card = deck.getTopCard() as! SuitedCard
        let cardView = SuitedCardView(card: card, initialFace: .Back)
        
        let width = UIScreen.mainScreen().bounds.width / 2
        let height = width / 0.7
        cardView.frame = CGRect(x: 70, y:70, width: width, height: height)
        
        arr.append(cardView)
        boardView.addSubview(cardView)
        cardView.flip()
    }
    
}