//
//  Table.h
//  Snap
//
//  Created by Joey Clover on 16/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Seat.h"
#import "Card.h"
@class CardView;


/**
 A table for the game of snap. The table contains seats and the logic to determine who take next turn 
 by using the seat positions.
 */
@interface Table : NSObject

// The seats on the table
@property (strong, nonatomic) NSMutableDictionary *seats;

/** Adds a seat to the table at a given position */
- (void)addSeat:(Seat *)seat;

/** Removes a seat from a given position */
- (void)removeSeatFromPosition:(SeatPosition)position;

/** Gets the next seat from the table (clockwise position) */
- (Seat *)nextSeat:(Seat *)currentSeat;

/** Gets a seat at a given position */
- (Seat *)seatForPosition:(SeatPosition)position;

/** Gets the position for card view at a given seat */
+ (CGRect)initialFrameForCardWithWidth:(CGFloat)width cardHeight:(CGFloat)height atSeat:(Seat *)seat;

/** Gets the flip direction of a card from the given seat */
+ (CardFlipDirection)flipDirectionForSeat:(Seat *)seat;

@end
