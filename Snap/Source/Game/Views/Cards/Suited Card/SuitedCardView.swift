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
    var backView: SuitedCardBackView
    var frontDecorator: SuitedCardViewDecorator?
    
    var suitCharacter:String = "?"
    var valueText:String = "??"
    
    var card: SuitedCard? { didSet {
        didUpdateCard()
    }}
    
    var face: SuitedCardFace? { willSet {
        updateFace(newValue)
    }}
    
    
    // MARK: Initialization
    
    required init(card: SuitedCard, initialFace: SuitedCardFace = .Back) {
        self.frontView = SuitedCardFrontView()
        self.backView = SuitedCardBackView()
        
        self.face = initialFace
        self.card = card
        self.frontDecorator = SuitedCardViewDecorator(collectionView: frontView.suitCollectionView, andCard: self.card)
        
        super.init(frame: CGRectZero)
        didUpdateCard()
        updateFace(self.face)
    }

    required convenience init(coder: NSCoder) {
        self.init(card:SuitedCard())
    }
    

    // MARK: Setup
    
    override func setup() {
        setupLayer()
        setupFrontView()
        setupBackView()
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
    
    func setupBackView() {
        self.addSubview(backView)
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
    
    
    // MARK: Face Update
    
    func updateFace(newFace:SuitedCardFace?) {
        if (newFace == self.face || newFace == nil) { return }
        if (face == nil) { showFace(newFace!); return }
        
        flip()
    }
    
    private func showFace(face:SuitedCardFace) {
        switch face {
        case .Front:
            self.frontView.alpha = 1
            self.backView.alpha = 0
        case .Back:
            self.frontView.alpha = 0
            self.backView.alpha = 1
        }
    }
    
    func flip() {
        guard let face = self.face else { return }
        
        switch face {
        case .Front:
            animateToFace(.Back)
        case .Back:
            animateToFace(.Front)
        }
    }
    
    private func animateToFace(face:SuitedCardFace) {
        
        UIView.animateWithDuration(2){
        
        if face == .Front {
            self.frontView.alpha = 1
            self.backView.alpha = 0
        }
        else {
            self.frontView.alpha = 0
            self.backView.alpha = 1
        }
            
        }
    }
    
}