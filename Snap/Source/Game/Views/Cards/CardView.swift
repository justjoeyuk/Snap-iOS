//
//  CardView.swift
//  Snap
//
//  Created by Joey Clover on 16/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

import Foundation
import UIKit


@objc
class CardView: BaseView {
    
    var frontView: CardFaceView
    var backView: CardFaceView
    
    private var currentFlipDirection: CardViewFlipDirection?
    private var oppositeFlipDirection: CardViewFlipDirection?
    
    var card: Card? { didSet {
        didUpdateCard()
        }}
    
    var face: CardViewFace? { willSet {
        updateFace(newValue)
        }}
    
    
    // MARK: Initialization
    
    required init(card: Card, initialFace: CardViewFace = .Back) {
        self.frontView = CardFaceView.frontFaceView(card)!
        self.backView = CardFaceView.backFaceView(card)!
        
        self.face = initialFace
        self.card = card
        
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
        if self.card == nil { return }
        
        frontView.cardDidUpdate(self.card!)
    }
    
    
    // MARK: Face Update
    
    private func updateFace(newFace:CardViewFace?) {
        if (newFace == nil) { return }
        showFace(newFace!)
    }
    
    private func showFace(face:CardViewFace) {
        switch face {
        case .Front:
            self.frontView.hidden = false
            self.backView.hidden = true
        case .Back:
            self.frontView.hidden = true
            self.backView.hidden = false
        }
    }
    
    func flip(var flipDirection:CardViewFlipDirection = .FromOpposite, completion:SingleBoolCallback? = nil) {
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
    
    private func animateToFace(face:CardViewFace, direction:CardViewFlipDirection, completion:SingleBoolCallback? = nil) {
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

extension CardView {
    
    override func setupConstraints() {
        
        self.frontView.snp_remakeConstraints() { make in
            make.edges.equalTo(self)
        }
        
        self.backView.snp_remakeConstraints() { make in
            make.edges.equalTo(self)
        }
        
    }
    
}




// MARK: Enumerations

/** Contains directions in which to flip the card view from */
enum CardViewFlipDirection {
    case FromOpposite
    case FromTop
    case FromLeft
    case FromRight
    case FromBottom
}

enum CardViewFace {
    case Front
    case Back
}