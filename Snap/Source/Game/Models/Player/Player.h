//
//  Player.h
//  Snap
//
//  Created by Joey Clover on 16/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stack.h"


/**
 Represents a player in a game of snap. Each player has a stack of cards and a name. Each turn a player will have a card removed from their stack.
 */
@interface Player : NSObject

/** The name of the player */
@property (strong, nonatomic) NSString *name;

/** The stack that the player holds */
@property (strong, nonatomic) Stack *cardStack;


/** Initializes the player with a name and a stack */
- (instancetype)initWithName:(NSString *)name cardStack:(Stack *)stack;

@end
