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
    
    var decorator: SuitedCardViewDecorator?
    var suitCollectionView: UICollectionView
    
    var suitCharacter:String = "?"
    var valueText:String = "??"
    
    let topValueLabel = UILabel(), bottomValueLabel = UILabel()
    let topSuitLabel = UILabel(), bottomSuitLabel = UILabel()
    
    var card: SuitedCard? { didSet {
        didUpdateCard()
    }}
    
    
    required init(card: SuitedCard) {
        
        let layout = UICollectionViewFlowLayout()
        self.suitCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        self.card = card
        self.decorator = SuitedCardViewDecorator(collectionView: suitCollectionView, andCard: self.card)
        
        super.init(frame: CGRectZero)
        didUpdateCard()
    }

    required convenience init(coder: NSCoder) {
        self.init(card:SuitedCard())
    }
    

    
    override func setup() {
        bottomSuitLabel.layer.setAffineTransform(CGAffineTransformMakeScale(1, -1))
        bottomValueLabel.layer.setAffineTransform(CGAffineTransformMakeScale(1, -1))
        suitCollectionView.backgroundColor = UIColor.whiteColor()
        
        let font = UIFont.systemFontOfSize(UIFont.systemFontSize()*UIScreen.mainScreen().bounds.width/300)
        topValueLabel.font = font
        topSuitLabel.font = font
        bottomValueLabel.font = font
        bottomSuitLabel.font = font
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.cornerRadius = 5
        
        addSubview(suitCollectionView)
        addSubview(topValueLabel)
        addSubview(topSuitLabel)
        addSubview(bottomValueLabel)
        addSubview(bottomSuitLabel)
    }
    
    func didUpdateCard() {
        self.backgroundColor = UIColor.whiteColor()
        suitCharacter = SuitedCard.characterForSuit(card!.suit)
        
        
        let cardValue = self.card!.value.rawValue
        let ace = SuitedCardValue.Ace.rawValue
        let jack = SuitedCardValue.Jack.rawValue
        let queen = SuitedCardValue.Queen.rawValue
        let king = SuitedCardValue.King.rawValue
        
        switch cardValue
        {
        case ace:
            valueText = "A"
        case (2...10):
            valueText = "\(cardValue)"
        case jack:
            valueText = "J"
        case queen:
            valueText = "Q"
        case king:
            valueText = "K"
        default:
            valueText = "?"
        }
        
        topValueLabel.text = "\(valueText)"
        topSuitLabel.text = "\(suitCharacter)"
        
        bottomValueLabel.text = "\(valueText)"
        bottomSuitLabel.text = "\(suitCharacter)"
    }
    
}