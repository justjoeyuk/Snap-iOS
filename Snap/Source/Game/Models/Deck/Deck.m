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

- (void)addCard:(Card *)card
{
    [self.cards addObject:card];
}

@end
