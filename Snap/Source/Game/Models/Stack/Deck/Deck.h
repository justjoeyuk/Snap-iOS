//
//  Deck.h
//  Snap
//
//  Created by Joey Clover on 11/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

#import "Stack.h"
#import "Stack_Private.h"

/**
 An extension of a stack that has shuffling, filling and removing of all cards
 */
@interface Deck : Stack

/** Adds a full set of suited cards to the deck */
- (void)fillWithCards:(NSArray<id<Card>> *)cards;

/** Removes all cards from the deck */
- (void)removeAllCards;

/** Splits the deck into an Array of stacks */
- (NSArray<Stack *> *)split:(NSUInteger)numStacks;

@end
