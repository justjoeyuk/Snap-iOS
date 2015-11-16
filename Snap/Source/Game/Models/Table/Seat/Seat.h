//
//  Seat.h
//  Snap
//
//  Created by Joey Clover on 16/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Player;


typedef NS_ENUM(NSUInteger, SeatPosition) {
    North,
    East,
    South,
    West
};


/**
 A seat at the game table. A seat contains a player.
 */
@interface Seat : NSObject

// The player assigned to the seat
@property (weak, nonatomic) Player *player;

// The position of the seat on the table
@property (assign, nonatomic) SeatPosition position;


/** 
 Initialise a seat with a player
 */
- (instancetype)initWithPlayer:(Player *)player atPosition:(SeatPosition)position;

@end
