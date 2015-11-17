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
    
    var snapButton: ActionButton
    var playButton: ActionButton
    
    
    override init(frame: CGRect) {
        northPlayerInfoView = PlayerInformationView()
        eastPlayerInfoView = PlayerInformationView()
        westPlayerInfoView = PlayerInformationView()
        southPlayerInfoView = PlayerInformationView()
        
        playButton = ActionButton(type: .System)
        snapButton = ActionButton(type: .System)
        
        super.init(frame: frame)
    }
    
    
    // MARK: Setup
    
    override func setup() {
        self.backgroundColor = UIColor(patternImage: UIImage(named: "Table Texture Image")!)
        
        setupSnapButton()
        setupPlayButton()
        setupInfoViews()
    }
    
    private func setupSnapButton() {
        snapButton.setTitle("Snap!", forState: .Normal)
        snapButton.backgroundColor = UIColor(red: 0.7, green: 0.3, blue: 0.3, alpha: 1)
        
        snapButton.hidden = true
        addSubview(snapButton)
    }
    
    private func setupPlayButton() {
        playButton.setTitle("Play", forState: .Normal)
        playButton.backgroundColor = UIColor(red: 0.3, green: 0.7, blue: 0.3, alpha: 1)
        
        addSubview(playButton)
    }
    
    private func setupInfoViews() {
        westPlayerInfoView.hidden = true
        eastPlayerInfoView.hidden = true
        northPlayerInfoView.hidden = true
        southPlayerInfoView.hidden = true
        
        addSubview(westPlayerInfoView)
        addSubview(eastPlayerInfoView)
        addSubview(northPlayerInfoView)
        addSubview(southPlayerInfoView)
    }
    
    
    // MARK: Buttons
    
    func showPlayButton() {
        self.playButton.hidden = false
        self.snapButton.hidden = true
    }
    
    func showSnapButton() {
        self.snapButton.hidden = false
        self.playButton.hidden = true
    }
    
    
    // MARK: Player Information
    
    func updatePlayerInformationForSeats(seats:Array<Seat>) {
        seats.forEach() { seat in
            self.updatePlayerInformationForSeat(seat)
        }
    }
    
    func updatePlayerInformationForSeat(seat:Seat) {
        switch (seat.position) {
        case .North: northPlayerInfoView.updateForPlayer(seat.player)
        case .East: eastPlayerInfoView.updateForPlayer(seat.player)
        case .West: westPlayerInfoView.updateForPlayer(seat.player)
        case .South: southPlayerInfoView.updateForPlayer(seat.player)
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
        
        self.snapButton.snp_makeConstraints() { make in
            make.bottom.equalTo(self.southPlayerInfoView.snp_top).offset(-30)
            make.centerX.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.5)
        }
        
        self.playButton.snp_makeConstraints() { make in
            make.edges.equalTo(self.snapButton)
        }
    }
    
}