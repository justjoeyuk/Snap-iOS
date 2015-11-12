//
//  SuitedCardViewDecorator.m
//  Snap
//
//  Created by Joey Clover on 12/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

#import "SuitedCardViewDecorator.h"
#import "SuitedLayoutParser.h"
#import "Snap-Swift.h"


@interface SuitedCardViewDecorator()

@property (weak, nonatomic) SuitedCard *card;

@end


@implementation SuitedCardViewDecorator

- (instancetype)initWithCollectionView:(UICollectionView *)view andCard:(SuitedCard *)card
{
    if (self = [super init]) {
        NSString *identifier = [SuitedCardCollectionViewCell identifier];
        [view registerClass:[SuitedCardCollectionViewCell class] forCellWithReuseIdentifier:identifier];
        
        view.dataSource = self;
        view.delegate = self;
        
        self.card = card;
        return self;
    }
    
    return nil;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 21;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [SuitedCardCollectionViewCell identifier];
    SuitedCardCollectionViewCell *cell = (SuitedCardCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if ([SuitedLayoutParser suitExistsForValue:self.card.value atPosition:indexPath.item]) {
        cell.characterLabel.text = @"♠";
    }
    else {
        cell.characterLabel.text = @"";
    }
    
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = floorf(collectionView.frame.size.width/3) - 1;
    CGFloat height = floorf(collectionView.frame.size.height/7) - 1;
    return CGSizeMake(width, height);
}

@end
