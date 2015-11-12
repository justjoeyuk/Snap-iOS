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
    
    
    // MARK: Initialization
    
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
    

    // MARK: Setup
    
    override func setup() {
        setupLayer()
        setupTopSuitLabel()
        setupTopValueLabel()
        setupBottomSuitLabel()
        setupBottomValueLabel()
        setupSuitCollectionView()
    }
    
    func setupLayer() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.cornerRadius = 5
    }
    
    func setupTopSuitLabel() {
        topSuitLabel.font = UIFont.standardScaledSystemFont()
        addSubview(topSuitLabel)
    }
    
    func setupTopValueLabel() {
        topValueLabel.font = UIFont.standardScaledSystemFont()
        addSubview(topValueLabel)
    }
    
    func setupBottomSuitLabel() {
        bottomSuitLabel.font = UIFont.standardScaledSystemFont()
        bottomSuitLabel.layer.setAffineTransform(CGAffineTransformMakeScale(1, -1))
        addSubview(bottomSuitLabel)
    }
    
    func setupBottomValueLabel() {
        bottomValueLabel.font = UIFont.standardScaledSystemFont()
        bottomValueLabel.layer.setAffineTransform(CGAffineTransformMakeScale(1, -1))
        
        addSubview(bottomValueLabel)
    }
    
    func setupSuitCollectionView() {
        suitCollectionView.backgroundColor = UIColor.whiteColor()
        addSubview(suitCollectionView)
    }
    
    
    // MARK: Card Update
    
    func didUpdateCard() {
        self.backgroundColor = UIColor.whiteColor()
        suitCharacter = SuitedCard.characterForSuit(card!.suit)
        valueText = SuitedCard.charactersForValue(card!.value)
        
        bottomValueLabel.textColor = SuitedCard.colorForSuit(card!.suit)
        topValueLabel.textColor = SuitedCard.colorForSuit(card!.suit)
        
        topValueLabel.text = "\(valueText)"
        topSuitLabel.text = "\(suitCharacter)"
        
        bottomValueLabel.text = "\(valueText)"
        bottomSuitLabel.text = "\(suitCharacter)"
    }
    
}