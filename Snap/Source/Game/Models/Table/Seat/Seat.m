//
//  Seat.m
//  Snap
//
//  Created by Joey Clover on 16/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

#import "Seat.h"
#import "Player.h"

@implementation Seat

- (instancetype)initWithPlayer:(Player *)player atPosition:(SeatPosition)position
{
    if (self = [super init]) {
        self.player = player;
        self.position = position;
        
        player.seatPosition = position;
    }
    
    return self;
}

@end
