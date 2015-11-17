//
//  PlayerInformationView.swift
//  Snap
//
//  Created by Joey Clover on 16/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

import UIKit


class PlayerInformationView: BaseView {
    
    var playerNameLabel, playerCardCountLabel: UILabel
    
    
    override init(frame: CGRect) {
        playerNameLabel = UILabel()
        playerCardCountLabel = UILabel()
        
        super.init(frame: frame)
    }
    
    
    // MARK: Setup
    
    override func setup() {
        self.backgroundColor = UIColor.clearColor()
        
        setupNameLabel()
        setupCardCountLabel()
    }
    
    private func setupNameLabel() {
        playerNameLabel.font = UIFont.scaledBoldSystemFontWithSize(10, andScaleFactor: kStandardScaleFactor)
        playerNameLabel.textAlignment = .Center
        addSubview(playerNameLabel)
    }
    
    private func setupCardCountLabel() {
        playerCardCountLabel.font = UIFont.scaledSystemFontWithSize(10, andScaleFactor: kStandardScaleFactor)
        playerCardCountLabel.textAlignment = .Center
        
        addSubview(playerCardCountLabel)
    }
    
    
    // MARK: Update
    
    func updateForPlayer(player:Player?) {
        if let player = player {
            self.hidden = false
            let count = (player.cardStack == nil) ? 0 : player.cardStack.count
            
            playerNameLabel.text = player.name
            playerCardCountLabel.text = "\(count) Cards"
            
            updateConstraints()
        }
        else {
            self.hidden = true
        }
    }
    
}


// MARK: Layout

extension PlayerInformationView {
    
    override func setupConstraints() {
        playerNameLabel.snp_makeConstraints() { make in
            make.top.equalTo(self)
            make.left.equalTo(self).priorityLow()
            make.right.equalTo(self).priorityLow()
            make.centerX.equalTo(self)
        }
        
        playerCardCountLabel.snp_makeConstraints() { make in
            make.top.equalTo(self.playerNameLabel.snp_bottom).offset(4)
            make.centerX.equalTo(self)
            make.width.equalTo(self).priorityLow()
            make.bottom.equalTo(self)
        }
    }
    
}