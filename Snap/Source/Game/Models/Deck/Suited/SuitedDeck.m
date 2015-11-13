//
//  SuitedDeck.m
//  Snap
//
//  Created by Joey Clover on 13/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

#import "Deck_Private.h"
#import "SuitedDeck.h"
#import "SuitedCard.h"


@implementation SuitedDeck

- (void)fillWithCards
{
    for (int suit = 0; suit <= 3; suit++) {
        for (int value = 1; value <= 13; value++) {
            SuitedCard *newCard = [[SuitedCard alloc] initWithSuit:suit andValue:value];
            [self addCard:newCard];
        }
    }
}

- (id)copyWithZone:(NSZone *)zone
{
    SuitedDeck *newDeck = [[SuitedDeck alloc] init];
    newDeck.cards = [[NSMutableArray alloc] initWithArray:self.cards copyItems:YES];
    return newDeck;
}

@end
