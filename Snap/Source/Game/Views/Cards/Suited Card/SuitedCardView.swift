//
//  CardView.swift
//  Snap
//
//  Created by Joey Clover on 11/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

import Foundation
import UIKit


/** Contains directions in which to flip the card view from */
enum SuitedCardFlipDirection {
    case FromTop
    case FromLeft
    case FromRight
    case FromBottom
}


class SuitedCardView: BaseView {
    
    private var frontView: SuitedCardFrontView
    private var backView: SuitedCardBackView
    private var frontDecorator: SuitedCardViewDecorator?
    
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
        self.backgroundColor = UIColor.clearColor()
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
        if (newFace == nil) { return }
        showFace(newFace!)
    }
    
    private func showFace(face:SuitedCardFace) {
        switch face {
        case .Front:
            self.frontView.hidden = false
            self.backView.hidden = true
        case .Back:
            self.frontView.hidden = true
            self.backView.hidden = false
        }
    }
    
    func flip() {
        if self.face == nil { return }
        
        switch self.face! {
        case .Front:
            animateToFace(.Back)
        case .Back:
            animateToFace(.Front)
        }
    }
    
    private func animateToFace(face:SuitedCardFace) {
        self.face = face
        
        self.frontView.hidden = true
        self.backView.hidden = false
        
        UIView.transitionFromView(self.backView, toView: self.frontView, duration: 0.6, options: [.ShowHideTransitionViews, .TransitionFlipFromTop, .CurveLinear], completion: nil)
    }
    
}


// MARK: Layout

extension SuitedCardView {
    
    override func setupConstraints() {
        
        self.frontView.snp_remakeConstraints() { make in
            make.edges.equalTo(self)
        }
        
        self.backView.snp_remakeConstraints() { make in
            make.edges.equalTo(self)
        }
        
    }
    
}