//
//  Deck.m
//  Snap
//
//  Created by Joey Clover on 11/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//
#import "Deck.h"
#import "Card.h"
#import "SuitedCard.h"


@implementation Deck

- (void)fillWithCards:(NSArray<id<Card>> *)cards
{
    self.cards = [cards mutableCopy];
}

- (void)removeAllCards
{
    [self.cards removeAllObjects];
}

- (NSArray<Stack *> *)split:(NSUInteger)numStacks
{
    NSMutableArray *stacks = [NSMutableArray arrayWithCapacity:numStacks];
    int bestSplit = floor(self.cards.count/numStacks);
    
    for (int stack = 0; stack < numStacks; stack++) {
        Stack *newStack = [[Stack alloc] initWithCapacity:bestSplit];
        
        for (int card = 0; card < bestSplit; card++) {
            [newStack addCard:[self getTopCard]];
        }
        
        [stacks addObject:newStack];
    }
    
    return [stacks copy];
}

@end
