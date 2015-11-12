//
//  CardView+Layout.swift
//  Snap
//
//  Created by Joey Clover on 11/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

import Foundation
import SnapKit


extension SuitedCardView {
    
    override func setupConstraints() {
        
        self.frontView.snp_makeConstraints() { make in
            make.edges.equalTo(self)
        }
        
        self.backView.snp_makeConstraints() { make in
            make.edges.equalTo(self)
        }
        
    }
    
}