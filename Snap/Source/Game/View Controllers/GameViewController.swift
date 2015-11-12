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
    
    
    override func loadView() {
        self.view = BoardView()
    }
    
    override func setup() {
        let card = SuitedCard(suit: .Spades, andValue: SuitedCardValue(rawValue: 10)!)
        let cardView = SuitedCardView(card: card)
        
        let width = UIScreen.mainScreen().bounds.width / 2
        let height = width / 0.7
        cardView.frame = CGRect(x: 70, y:70, width: width, height: height)
        
        boardView.addSubview(cardView)
    }
    
}