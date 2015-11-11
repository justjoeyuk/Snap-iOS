//
//  BaseView.swift
//  Snap
//
//  Created by Joey Clover on 11/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class BaseView: UIView {
  
  // Spacers for AutoLayout
  let leftSpacer: UIView = UIView()
  let rightSpacer: UIView = UIView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    // Disable Autoresize Masks
    self.translatesAutoresizingMaskIntoConstraints = true
    self.backgroundColor = UIColor.whiteColor()
    
    setup()
    setupConstraints()
  }
  
  required convenience init(coder: NSCoder) {
    self.init(frame:CGRectZero)
  }
  
  func setup() {}
  
}


extension BaseView {
  
  func setupConstraints() {}
  
  func setupSpaceConstraints() {
    self.leftSpacer.translatesAutoresizingMaskIntoConstraints = false
    self.rightSpacer.translatesAutoresizingMaskIntoConstraints = false;
    
    self.addSubview(leftSpacer)
    self.addSubview(rightSpacer)
    
    leftSpacer.snp_makeConstraints(){ make in
      make.centerY.equalTo(self)
      make.left.equalTo(self)
      make.width.greaterThanOrEqualTo(0).priorityHigh()
      make.height.equalTo(1)
    }
    
    rightSpacer.snp_makeConstraints(){ make in
      make.centerY.equalTo(self)
      make.right.equalTo(self)
      make.width.equalTo(self.leftSpacer).priorityLow()
      make.height.equalTo(1)
    }
  }
  
}