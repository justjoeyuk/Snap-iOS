//
//  DeckGenerator.m
//  Snap
//
//  Created by Joey Clover on 16/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

#import "DeckGenerator.h"
#import "SuitedCard.h"


@implementation DeckGenerator

+ (Deck *)generateSuitedDeck
{
    Deck *suitedDeck = [[Deck alloc] initWithCapacity:52];
    
    NSMutableArray *suitedCards= [NSMutableArray array];
    NSArray<id<Card>> *deckCards;
    
    for (int suit = 0; suit <= 3; suit++) {
        for (int value = 1; value <= 13; value++) {
            SuitedCard *card = [[SuitedCard alloc] initWithSuit:suit andValue:value];
            [suitedCards addObject:card];
        }
    }
    
    deckCards = [suitedCards copy];
    [suitedDeck fillWithCards:deckCards];
    
    return suitedDeck;
}

@end