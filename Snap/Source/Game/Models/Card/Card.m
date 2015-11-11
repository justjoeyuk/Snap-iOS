//
//  Card.m
//  Snap
//
//  Created by Joey Clover on 11/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

#import "Card.h"


@interface Card()

@property (assign, nonatomic) CardSuit suit;
@property (assign, nonatomic) CardValue value;

@end


@implementation Card

- (instancetype)initWithSuit:(CardSuit)suit andValue:(CardValue)value
{
    if (self = [super init]) {
        self.value = value;
        self.suit = suit;
        
        return self;
    }
    
    return nil;
}


- (id)copyWithZone:(NSZone *)zone
{
    return [[Card alloc] initWithSuit:self.suit andValue:self.value];
}


- (BOOL)isEqual:(id)object
{
    Card *otherCard = (Card *)object;
    if (otherCard) {
        return (otherCard.value == self.value && otherCard.suit == self.suit);
    }
    
    return NO;
}

@end