//
//  Card.m
//  Snap
//
//  Created by Joey Clover on 11/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

#import "SuitedCard.h"


@interface SuitedCard()

@property (assign, nonatomic) SuitedCardSuit suit;
@property (assign, nonatomic) SuitedCardValue value;

@end


@implementation SuitedCard


#pragma mark Initialization

- (instancetype)initWithSuit:(SuitedCardSuit)suit andValue:(SuitedCardValue)value
{
    if (self = [super init]) {
        self.value = value;
        self.suit = suit;
        
        return self;
    }
    
    return nil;
}


+ (NSString *)characterForSuit:(SuitedCardSuit)suit
{
    NSString *character = @"?";
    
    switch (suit)
    {
    case Clubs:
        character = @"♣";
            break;
    case Diamonds:
        character = @"♦";
            break;
    case Hearts:
        character = @"♥";
            break;
    case Spades:
        character = @"♠";
            break;
    }
    
    return character;
}

+ (NSString *)charactersForValue:(SuitedCardValue)value
{
    NSUInteger rawValue = value;
    NSString *character = @"";
    
    switch (rawValue) {
        case Ace:
            character = @"A";
            break;
        case Jack:
            character = @"J";
            break;
        case Queen:
            character = @"Q";
            break;
        case King:
            character = @"K";
            break;
        default:
            character = [NSString stringWithFormat:@"%d", (int)rawValue];
            break;
    }
    
    return character;
}


#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    return [[SuitedCard alloc] initWithSuit:self.suit andValue:self.value];
}


#pragma mark Comparison

- (BOOL)isEqual:(id)object
{
    SuitedCard *otherCard = (SuitedCard *)object;
    if (otherCard) {
        return (otherCard.value == self.value && otherCard.suit == self.suit);
    }
    
    return NO;
}


#pragma mark Card Protocol

- (NSUInteger)numericIdentifier
{
    return self.value;
}

@end