//
//  SnapButton.swift
//  Snap
//
//  Created by Joey Clover on 17/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

import UIKit


class ActionButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    private func setup() {
        self.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5
    }
    
}