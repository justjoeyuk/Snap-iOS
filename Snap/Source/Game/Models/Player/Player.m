//
//  Player.m
//  Snap
//
//  Created by Joey Clover on 16/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

#import "Player.h"

@implementation Player

- (instancetype)initWithName:(NSString *)name cardStack:(Stack *)stack
{
    if (self = [super init]) {
        self.name = name;
        self.cardStack = stack;
    }
    
    return self;
}

@end
