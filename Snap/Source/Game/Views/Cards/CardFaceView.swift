//
//  CardFaceView.swift
//  Snap
//
//  Created by Joey Clover on 16/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

import UIKit

class CardFaceView: BaseView {
    
    class func frontFaceView(card:Card) -> CardFaceView? {
        if let suitedCard = card as? SuitedCard { return SuitedCardFrontView(card: suitedCard) }
        
        return nil
    }
    
    class func backFaceView(card:Card) -> CardFaceView? {
        if let _ = card as? SuitedCard { return SuitedCardBackView() }
        
        return nil
    }
    
    func cardDidUpdate(card:Card) {preconditionFailure("This method must be overridden") }
    
}
