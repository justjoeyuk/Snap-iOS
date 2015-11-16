//
//  SuitedCardBackView.swift
//  Snap
//
//  Created by Joey Clover on 12/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

import UIKit


class SuitedCardBackView: CardFaceView {
    
    override func setup() {
        self.backgroundColor = UIColor(patternImage: UIImage(named: "Suited Background Image")!)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.cornerRadius = 5
    }
    
}