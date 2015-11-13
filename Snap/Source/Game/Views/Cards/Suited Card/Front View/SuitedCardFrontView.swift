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
    private var decorator: SuitedCardViewDecorator?
    
    
    // MARK: Initialisation
    
    override init(frame:CGRect) {
        let layout = UICollectionViewFlowLayout()
        self.suitCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        
        super.init(frame: frame)
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