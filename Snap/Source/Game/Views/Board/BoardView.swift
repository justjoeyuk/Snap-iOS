//
//  BoardView.swift
//  Snap
//
//  Created by Joey Clover on 11/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

import Foundation
import UIKit


class BoardView: BaseView {
    
    var northPlayerInfoView: PlayerInformationView
    var eastPlayerInfoView: PlayerInformationView
    var westPlayerInfoView: PlayerInformationView
    var southPlayerInfoView: PlayerInformationView
    
    
    override init(frame: CGRect) {
        northPlayerInfoView = PlayerInformationView()
        eastPlayerInfoView = PlayerInformationView()
        westPlayerInfoView = PlayerInformationView()
        southPlayerInfoView = PlayerInformationView()
        
        super.init(frame: frame)
    }
    
    override func setup() {
        self.backgroundColor = UIColor(patternImage: UIImage(named: "Table Texture Image")!)
        
        addSubview(westPlayerInfoView)
        addSubview(eastPlayerInfoView)
        addSubview(northPlayerInfoView)
        addSubview(southPlayerInfoView)
    }
    
    func showPlayerInformationForSeat(seat:Seat) {
        switch (seat.position) {
        case .North: northPlayerInfoView.updateForPlayer(seat.player!)
        case .East: eastPlayerInfoView.updateForPlayer(seat.player!)
        case .West: westPlayerInfoView.updateForPlayer(seat.player!)
        case .South: southPlayerInfoView.updateForPlayer(seat.player!)
        }
        
        
    }
    
}


// MARK: Layout

extension BoardView {
    
    override func setupConstraints() {
        self.northPlayerInfoView.snp_makeConstraints() { make in
            make.top.equalTo(self).offset(10)
            make.centerX.equalTo(self)
        }
        
        self.eastPlayerInfoView.snp_makeConstraints() { make in
            make.centerY.equalTo(self).offset(-40)
            make.right.equalTo(self).offset(-10)
        }
        
        self.westPlayerInfoView.snp_makeConstraints() { make in
            make.centerY.equalTo(self.eastPlayerInfoView)
            make.left.equalTo(self).offset(10)
        }
        
        self.southPlayerInfoView.snp_makeConstraints() { make in
            make.bottom.equalTo(self).offset(-10)
            make.centerX.equalTo(self)
        }
    }
    
}