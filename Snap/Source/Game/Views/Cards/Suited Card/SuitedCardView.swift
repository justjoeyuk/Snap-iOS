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
    case FromOpposite
    case FromTop
    case FromLeft
    case FromRight
    case FromBottom
}


class SuitedCardView: BaseView {
    
    private var frontView: SuitedCardFrontView
    private var backView: SuitedCardBackView
    private var frontDecorator: SuitedCardViewDecorator?
    
    private var currentFlipDirection: SuitedCardFlipDirection?
    private var oppositeFlipDirection: SuitedCardFlipDirection?
    
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
    
    func flip(var flipDirection:SuitedCardFlipDirection = .FromOpposite, completion:SingleBoolCallback? = nil) {
        if self.face == nil { return }
        
        if (flipDirection == .FromOpposite && self.oppositeFlipDirection == nil) {
            flipDirection = .FromLeft
        }
        
        switch flipDirection {
        case .FromLeft:
            self.oppositeFlipDirection = .FromRight
        case .FromRight:
            self.oppositeFlipDirection = .FromLeft
        case .FromBottom:
            self.oppositeFlipDirection = .FromTop
        case .FromTop:
            self.oppositeFlipDirection = .FromBottom
        case .FromOpposite:
            let temp = self.oppositeFlipDirection
            self.oppositeFlipDirection = self.currentFlipDirection
            flipDirection = temp!
        }
        
        self.currentFlipDirection = flipDirection
        
        switch self.face! {
        case .Front:
            animateToFace(.Back, direction:self.currentFlipDirection!, completion: completion)
        case .Back:
            animateToFace(.Front, direction:self.currentFlipDirection!, completion: completion)
        }
    }
    
    private func animateToFace(face:SuitedCardFace, direction:SuitedCardFlipDirection, completion:SingleBoolCallback? = nil) {
        let fromView = (self.face == .Front) ? self.frontView : self.backView
        let toView = (self.face == .Front) ? self.backView : self.frontView
        
        self.face = face
        
        toView.hidden = true
        fromView.hidden = false
        
        var transitionAnimation: UIViewAnimationOptions
        switch direction {
        case .FromLeft:
            transitionAnimation = .TransitionFlipFromLeft
        case .FromRight:
            transitionAnimation = .TransitionFlipFromRight
        case .FromTop:
            transitionAnimation = .TransitionFlipFromTop
        case .FromBottom:
            transitionAnimation = .TransitionFlipFromBottom
        default:
            transitionAnimation = .TransitionNone
        }
        
        CATransaction.flush()
        UIView.transitionFromView(fromView, toView: toView, duration: 0.8, options: [.ShowHideTransitionViews, transitionAnimation, .CurveLinear], completion: completion)
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