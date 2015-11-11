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
    var topValueLabel, bottomValueLabel: UILabel
    var topSuitLabel, bottomSuitLabel: UILabel
    var card: Card?
    
    
    convenience init(card: Card?) {
        self.init(frame:CGRectZero)
        self.card = card
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
        topValueLabel.text = "7"
        topSuitLabel.text = "♣"
        
        bottomValueLabel.text = "7"
        bottomSuitLabel.text = "♣"
        bottomSuitLabel.layer.setAffineTransform(CGAffineTransformMakeScale(1, -1))
        bottomValueLabel.layer.setAffineTransform(CGAffineTransformMakeScale(1, -1))
        
        let font = UIFont.systemFontOfSize(UIFont.systemFontSize()*UIScreen.mainScreen().bounds.width/200.0)
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
    
}