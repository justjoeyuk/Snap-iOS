//
//  Deck.h
//  Snap
//
//  Created by Joey Clover on 11/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Card;


/** 
 Represents a collection of Cards that can be shuffled and manipulated.
 
 @see Card
 */
@interface Deck : NSObject <NSCopying>

/** The internal collection of cards */
@property (strong, nonatomic, readonly) NSMutableArray *cards;


/** Initializes the Deck with a capacity */
- (instancetype)initWithCapacity:(NSUInteger)deckSize;

/** Adds all cards to the deck */
- (void)fillWithCards;

/** Shuffles all the cards randomly in the deck */
- (void)shuffleCards;

/** Adds a card to the end of the deck */
- (void)addCard:(Card *)card;

@end
