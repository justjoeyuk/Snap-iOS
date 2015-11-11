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
    
    var suitCollectionView: UICollectionView
    
    var suitCharacter:Character = "?"
    var valueText:String = "??"
    
    var topValueLabel, bottomValueLabel: UILabel
    var topSuitLabel, bottomSuitLabel: UILabel
    
    var card: SuitedCard? { didSet {
        didUpdateCard()
    }}
    
    
    convenience init(card: SuitedCard) {
        self.init(frame:CGRectZero)
        
        self.card = card
        didUpdateCard()
        
    }
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        suitCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        topValueLabel = UILabel()
        bottomValueLabel = UILabel()
        topSuitLabel = UILabel()
        bottomSuitLabel = UILabel()
        
        super.init(frame: frame)
    }
    
    override func setup() {
        bottomSuitLabel.layer.setAffineTransform(CGAffineTransformMakeScale(1, -1))
        bottomValueLabel.layer.setAffineTransform(CGAffineTransformMakeScale(1, -1))
        
        let font = UIFont.systemFontOfSize(UIFont.systemFontSize()*UIScreen.mainScreen().bounds.width/300)
        topValueLabel.font = font
        topSuitLabel.font = font
        bottomValueLabel.font = font
        bottomSuitLabel.font = font
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.cornerRadius = 5
        
        addSubview(topValueLabel)
        addSubview(topSuitLabel)
        addSubview(bottomValueLabel)
        addSubview(bottomSuitLabel)
    }
    
    func didUpdateCard() {
        self.backgroundColor = UIColor.whiteColor()
        
        switch self.card!.suit
        {
        case .Clubs:
            suitCharacter = "♣"
        case .Diamonds:
            suitCharacter = "♦"
        case .Hearts:
            suitCharacter = "♥"
        case.Spades:
            suitCharacter = "♠"
        }
        
        
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