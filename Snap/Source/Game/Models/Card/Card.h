//
//  Card.h
//  Snap
//
//  Created by Joey Clover on 11/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CardSuit) {
    Hearts,
    Diamonds,
    Spades,
    Clubs
};

typedef NS_ENUM(NSUInteger, CardValue) {
    Ace = 1,
    Jack = 11,
    Queen,
    King
};


/**
 Describes the model of a card. A card in Snap typically consists
 of a suit and a value. A value can represent an Ace, any number between 2-10 
 (inclusive), Jack, Queen and King.
 
 Example: 8 of Hearts
 */
@interface Card : NSObject <NSCopying>

/**
 The suit of the Card. It should be either Hearts, Diamonds, Spades or Clubs.
 */
@property (assign, nonatomic, readonly) CardSuit suit;

/**
 The value of the Card. It should be between 1-13
 */
@property (assign, nonatomic, readonly) CardValue value;


/** 
 Initializes a Card with a given suit and value.
 */
- (instancetype)initWithSuit:(CardSuit)suit andValue:(CardValue)value;

@end
