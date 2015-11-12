//
//  SuitedCardFrontView+Layout.swift
//  Snap
//
//  Created by Joey Clover on 12/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

import UIKit


extension SuitedCardFrontView {
    
    override func setupConstraints() {
        self.topValueLabel.snp_makeConstraints() { make in
            make.centerX.equalTo(self.topSuitLabel)
            make.top.equalTo(self).offset(5)
        }
        
        self.topSuitLabel.snp_makeConstraints() { make in
            make.top.equalTo(self.topValueLabel.snp_bottom).offset(2)
            make.left.equalTo(5)
        }
        
        self.bottomSuitLabel.snp_makeConstraints() { make in
            make.right.equalTo(self).offset(-5)
            make.bottom.equalTo(self.bottomValueLabel.snp_top).offset(-5)
        }
        
        self.bottomValueLabel.snp_makeConstraints() { make in
            make.bottom.equalTo(self).offset(-5)
            make.centerX.equalTo(self.bottomSuitLabel)
        }
        
        self.suitCollectionView.snp_makeConstraints() { make in
            make.top.equalTo(self).offset(5)
            make.left.equalTo(self.topSuitLabel.snp_right).offset(2)
            make.right.equalTo(self.bottomSuitLabel.snp_left).offset(-2)
            make.bottom.equalTo(self).offset(-5)
        }
    }
    
}