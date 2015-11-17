//
//  Stack.h
//  Snap
//
//  Created by Joey Clover on 16/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
@class CardFaceView;


/**
 Represents a collection of Cards that can be shuffled and manipulated.
 
 @see Card
 */
@interface Stack : NSObject

/** The internal collection of cards */
@property (strong, nonatomic, readonly) NSMutableArray<id<Card>> *cards;

/** The number of cards left in stack */
@property (assign, nonatomic, readonly) NSUInteger count;


/** Initializes the Deck with a capacity */
- (instancetype)initWithCapacity:(NSUInteger)deckSize;

/** Retrieves the last card added to the deck (FIFO) and removes it from the deck */
- (id<Card>)getTopCard;

/** Adds a card to the top of the deck */
- (void)addCard:(id<Card>)card;

/** Adds stack to the current stack */
- (void)addStack:(Stack *)otherStack;

/** Gets the back view for the cards in the deck */
- (CardFaceView *)backFaceView;

/** Shuffles all the cards randomly in the deck */
- (void)shuffleCards;

@end
