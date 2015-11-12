//
//  Card.h
//  Snap
//
//  Created by Joey Clover on 11/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"


typedef NS_ENUM(NSUInteger, SuitedCardSuit) {
    Hearts,
    Diamonds,
    Spades,
    Clubs
};

typedef NS_ENUM(NSUInteger, SuitedCardValue) {
    Ace = 1,
    Jack = 11,
    Queen,
    King
};

typedef NS_ENUM(NSUInteger, SuitedCardFace) {
    Front,
    Back
};


/**
 Describes the model of a standard suited card. A card in Snap typically consists
 of a suit and a value. A value can represent an Ace, any number between 2-10 
 (inclusive), Jack, Queen and King.
 
 Example: 8 of Hearts
 */
@interface SuitedCard: NSObject<Card, NSCopying>

/**
 The suit of the Card. It should be either Hearts, Diamonds, Spades or Clubs.
 */
@property (assign, nonatomic, readonly) SuitedCardSuit suit;

/** The value of the suited card, it can be between 1 and 13 */
@property (assign, nonatomic, readonly) SuitedCardValue value;


/** 
 Initializes a Card with a given suit and value.
 */
- (instancetype)initWithSuit:(SuitedCardSuit)suit andValue:(SuitedCardValue)value;

/**
 @return the character for the given suit (as NSString)
 */
+ (NSString *)characterForSuit:(SuitedCardSuit)suit;

/**
 @return the colour represented by the suit
 */
+ (UIColor *)colorForSuit:(SuitedCardSuit)suit;

/**
 @return the characters for the given value
 */
+ (NSString *)charactersForValue:(SuitedCardValue)value;

@end
