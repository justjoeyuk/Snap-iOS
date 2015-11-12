//
//  CardView.swift
//  Snap
//
//  Created by Joey Clover on 11/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

import Foundation
import UIKit


class SuitedCardView: BaseView {
    
    var frontView: SuitedCardFrontView
    var frontDecorator: SuitedCardViewDecorator?
    
    var suitCharacter:String = "?"
    var valueText:String = "??"
    
    var card: SuitedCard? { didSet {
        didUpdateCard()
    }}
    
    
    // MARK: Initialization
    
    required init(card: SuitedCard) {
        self.frontView = SuitedCardFrontView()
        self.card = card
        self.frontDecorator = SuitedCardViewDecorator(collectionView: frontView.suitCollectionView, andCard: self.card)
        
        super.init(frame: CGRectZero)
        didUpdateCard()
    }

    required convenience init(coder: NSCoder) {
        self.init(card:SuitedCard())
    }
    

    // MARK: Setup
    
    override func setup() {
        setupLayer()
        setupFrontView()
    }
    
    func setupLayer() {
        self.clipsToBounds = true
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.cornerRadius = 5
    }
    
    func setupFrontView() {
        self.addSubview(frontView)
    }
    
    
    // MARK: Card Update
    
    func didUpdateCard() {
        suitCharacter = SuitedCard.characterForSuit(card!.suit)
        valueText = SuitedCard.charactersForValue(card!.value)
        
        frontView.bottomValueLabel.textColor = SuitedCard.colorForSuit(card!.suit)
        frontView.topValueLabel.textColor = SuitedCard.colorForSuit(card!.suit)
        
        frontView.topValueLabel.text = "\(valueText)"
        frontView.topSuitLabel.text = "\(suitCharacter)"
        
        frontView.bottomValueLabel.text = "\(valueText)"
        frontView.bottomSuitLabel.text = "\(suitCharacter)"
    }
    
}