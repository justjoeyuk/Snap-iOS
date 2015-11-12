//
//  SuitedCardViewDecorator.h
//  Snap
//
//  Created by Joey Clover on 12/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuitedCard.h"


@interface SuitedCardViewDecorator : NSObject <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

- (instancetype)initWithCollectionView:(UICollectionView *)view andCard:(SuitedCard *)card;

@end
