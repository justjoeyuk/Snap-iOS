//
//  Stack.m
//  Snap
//
//  Created by Joey Clover on 16/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

#import "Stack.h"
#import "Stack_Private.h"
#import "Snap-Swift.h"


@implementation Stack

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


#pragma mark Cards

- (id<Card>)getTopCard
{
    id<Card> card = [self.cards lastObject];
    [self.cards removeLastObject];
    
    return card;
}

- (void)addCard:(id<Card>)card
{
    [self.cards addObject:card];
}

- (void)addStack:(Stack *)otherStack
{
    NSUInteger otherStackCount = otherStack.cards.count;
    
    for (int card = 0; card < otherStackCount; card++) {
        [self addCard:[otherStack getTopCard]];
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

- (NSUInteger)count
{
    return self.cards.count;
}


#pragma mark Views

- (CardFaceView *)backFaceView
{
    id<Card> card = [self.cards firstObject];
    return [CardFaceView backFaceView:card];
}


#pragma mark Comparison

- (BOOL)isEqual:(id)object
{
    Stack *otherStack = (Stack *)object;
    
    if (otherStack) {
        return [otherStack.cards isEqualToArray:self.cards];
    }
    
    return NO;
}

@end
