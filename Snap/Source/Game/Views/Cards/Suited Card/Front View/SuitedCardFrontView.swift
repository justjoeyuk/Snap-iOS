//
//  File.swift
//  Snap
//
//  Created by Joey Clover on 12/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

import UIKit


class SuitedCardFrontView : CardFaceView {
    
    private let topValueLabel = UILabel(), bottomValueLabel = UILabel()
    private let topSuitLabel = UILabel(), bottomSuitLabel = UILabel()
    private var suitCollectionView: UICollectionView!
    private var decorator: SuitedCardViewDecorator!
    
    var suitCharacter, valueText: String?
    
    
    // MARK: Initialisation
    
    init(card:SuitedCard) {
        let layout = UICollectionViewFlowLayout()
        suitCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        decorator = SuitedCardViewDecorator(collectionView: suitCollectionView, andCard: card)
        
        super.init(frame:CGRectZero)
    }

    required convenience init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    private func setupLayer() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.cornerRadius = 5
    }
    
    private func setupTopSuitLabel() {
        topSuitLabel.font = UIFont.standardScaledSystemFont()
        addSubview(topSuitLabel)
    }
    
    private func setupTopValueLabel() {
        topValueLabel.font = UIFont.standardScaledBoldSystemFont()
        addSubview(topValueLabel)
    }
    
    private func setupBottomSuitLabel() {
        bottomSuitLabel.font = UIFont.standardScaledSystemFont()
        bottomSuitLabel.layer.setAffineTransform(CGAffineTransformMakeScale(1, -1))
        addSubview(bottomSuitLabel)
    }
    
    private func setupBottomValueLabel() {
        bottomValueLabel.font = UIFont.standardScaledBoldSystemFont()
        bottomValueLabel.layer.setAffineTransform(CGAffineTransformMakeScale(1, -1))
        
        addSubview(bottomValueLabel)
    }
    
    private func setupSuitCollectionView() {
        suitCollectionView.backgroundColor = UIColor.whiteColor()
        addSubview(suitCollectionView)
    }
    
    
    // MARK FrontCardFaceView Protocol
    
    override func cardDidUpdate(card: Card) {
        if let suitedCard = card as? SuitedCard {
            bottomValueLabel.textColor = SuitedCard.colorForSuit(suitedCard.suit)
            topValueLabel.textColor = SuitedCard.colorForSuit(suitedCard.suit)
            
            bottomValueLabel.textColor = SuitedCard.colorForSuit(suitedCard.suit)
            topValueLabel.textColor = SuitedCard.colorForSuit(suitedCard.suit)
            
            suitCharacter = SuitedCard.characterForSuit(suitedCard.suit)
            valueText = SuitedCard.charactersForValue(suitedCard.value)
            
            topValueLabel.text = "\(valueText!)"
            topSuitLabel.text = "\(suitCharacter!)"
            
            bottomValueLabel.text = "\(valueText!)"
            bottomSuitLabel.text = "\(suitCharacter!)"
        }
    }
}


// MARK: Layout

extension SuitedCardFrontView {
    
    override func setupConstraints() {
        self.topValueLabel.snp_remakeConstraints() { make in
            make.centerX.equalTo(self.topSuitLabel)
            make.top.equalTo(self).offset(5)
        }
        
        self.topSuitLabel.snp_remakeConstraints() { make in
            make.top.equalTo(self.topValueLabel.snp_bottom).offset(2)
            make.left.equalTo(5)
        }
        
        self.bottomSuitLabel.snp_remakeConstraints() { make in
            make.right.equalTo(self).offset(-5)
            make.bottom.equalTo(self.bottomValueLabel.snp_top).offset(-5)
        }
        
        self.bottomValueLabel.snp_remakeConstraints() { make in
            make.bottom.equalTo(self).offset(-5)
            make.centerX.equalTo(self.bottomSuitLabel)
        }
        
        self.suitCollectionView.snp_remakeConstraints() { make in
            make.top.equalTo(self).offset(5)
            make.left.equalTo(self.topSuitLabel.snp_right).offset(2)
            make.right.equalTo(self.bottomSuitLabel.snp_left).offset(-2)
            make.bottom.equalTo(self).offset(-5)
        }
    }
    
}