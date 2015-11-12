//
//  SuitedCardCollectionViewCell.swift
//  Snap
//
//  Created by Joey Clover on 12/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

import Foundation
import UIKit
import SnapKit


class SuitedCardCollectionViewCell: UICollectionViewCell
{
    static let identifier = "SuitedCardCell"
    let characterLabel = UILabel()
    
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setupConstraints()
    }

    required convenience init(coder: NSCoder) {
        self.init(frame:CGRectZero)
    }
    
    
    // MARK: Setup
    
    func setup() {
        let font = UIFont.systemFontOfSize(UIFont.systemFontSize()*UIScreen.mainScreen().bounds.width/200)
        
        characterLabel.textAlignment = .Center
        characterLabel.font = font
        
        self.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(characterLabel)
    }
    
    
    // MARK: Layout
    
    func setupConstraints() {
        characterLabel.snp_makeConstraints() { make in
            make.edges.equalTo(self.contentView)
        }
    }
    
    
}