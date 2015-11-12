//
//  File.swift
//  Snap
//
//  Created by Joey Clover on 12/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

import UIKit


class SuitedCardFrontView : BaseView {
    
    let topValueLabel = UILabel(), bottomValueLabel = UILabel()
    let topSuitLabel = UILabel(), bottomSuitLabel = UILabel()
    var suitCollectionView: UICollectionView
    var decorator: SuitedCardViewDecorator?
    
    
    // MARK: Initialisation
    
    override init(frame:CGRect) {
        let layout = UICollectionViewFlowLayout()
        self.suitCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        
        super.init(frame: frame)
    }
    
    
    // MARK: Setup
    
    override func setup() {
        setupTopSuitLabel()
        setupTopValueLabel()
        setupBottomSuitLabel()
        setupBottomValueLabel()
        setupSuitCollectionView()
    }
    
    func setupTopSuitLabel() {
        topSuitLabel.font = UIFont.standardScaledSystemFont()
        addSubview(topSuitLabel)
    }
    
    func setupTopValueLabel() {
        topValueLabel.font = UIFont.standardScaledBoldSystemFont()
        addSubview(topValueLabel)
    }
    
    func setupBottomSuitLabel() {
        bottomSuitLabel.font = UIFont.standardScaledSystemFont()
        bottomSuitLabel.layer.setAffineTransform(CGAffineTransformMakeScale(1, -1))
        addSubview(bottomSuitLabel)
    }
    
    func setupBottomValueLabel() {
        bottomValueLabel.font = UIFont.standardScaledBoldSystemFont()
        bottomValueLabel.layer.setAffineTransform(CGAffineTransformMakeScale(1, -1))
        
        addSubview(bottomValueLabel)
    }
    
    func setupSuitCollectionView() {
        suitCollectionView.backgroundColor = UIColor.whiteColor()
        addSubview(suitCollectionView)
    }
    
}