//
//  Deck.m
//  Snap
//
//  Created by Joey Clover on 11/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

#import "Deck.h"
#import "Card.h"


@interface Deck()

@property (strong, nonatomic) NSMutableArray *cards;

@end


@implementation Deck


#pragma mark Initialization

- (instancetype)init
{
    if (self = [self initWithCapacity:52]) {
        return self;
    }
    
    return nil;
}

- (instancetype)initWithCapacity:(NSUInteger)deckSize
{
    if (self = [super init]) {
        self.cards = [NSMutableArray arrayWithCapacity:deckSize];
        return self;
    }
    
    return nil;
}


#pragma mark Deck Manipulation

- (void)fillWithCards
{
    for (int suit = 1; suit <= 4; suit++) {
        for (int value = 1; value <= 13; value++) {
            Card *newCard = [[Card alloc] initWithSuit:suit andValue:value];
            [self addCard:newCard];
        }
    }
}

- (void)shuffleCards
{
    NSArray *original = [[NSArray alloc] initWithArray:self.cards copyItems:YES];
    
    do {
        NSUInteger count = [self.cards count];
        for (NSUInteger i = 0; i < count - 1; ++i) {
            NSInteger remainingCount = count - i;
            NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
            [self.cards exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
        }
    } while ( [original isEqualToArray:self.cards] );
}

- (void)addCard:(Card *)card
{
    [self.cards addObject:card];
}


#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    Deck *newDeck = [[Deck alloc] init];
    newDeck.cards = [[NSMutableArray alloc] initWithArray:self.cards copyItems:YES];
    return newDeck;
}


#pragma mark Comparison

- (BOOL)isEqual:(id)object
{
    Deck *otherDeck = (Deck *)object;
    
    if (otherDeck) {
        return [otherDeck.cards isEqualToArray:self.cards];
    }
    
    return NO;
}

@end
