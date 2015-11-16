//
//  Table.m
//  Snap
//
//  Created by Joey Clover on 16/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

#import "Table.h"
#import "Snap-Swift.h"


@implementation Table

- (instancetype)init
{
    if (self = [super init]) {
        self.seats = [NSMutableDictionary dictionary];
    }
    
    return self;
}


// MARK: Seating

- (void)addSeat:(Seat *)seat
{
    Seat *currentSeatAtPosition = [self.seats objectForKey:@(seat.position)];
    if (currentSeatAtPosition == nil) {
        [self.seats setObject:seat forKey:@(seat.position)];
    }
    else {
        NSLog(@"Cannot add a Seat to a position that already has a position assigned!");
    }
}

- (void)removeSeatFromPosition:(SeatPosition)position
{
    [self.seats removeObjectForKey:@(position)];
}

- (Seat *)nextSeat:(Seat *)currentSeat
{
    if ([self.seats count] == 0) {
        NSLog(@"%@", @"Cannot get next seat. No seats at table.");
        return nil;
    }
    
    SeatPosition nextPosition = currentSeat.position;
    Seat *nextSeat = nil;
    
    do {
        switch (nextPosition) {
            case North:
                nextPosition = East;
                break;
            case East:
                nextPosition = South;
                break;
            case South:
                nextPosition = West;
                break;
            case West:
                nextPosition = North;
                break;
            default:
                nextPosition = currentSeat.position;
                break;
        }
        
        nextSeat = [self seatForPosition:nextPosition];
        
    } while (nextSeat == nil);
    
    return nextSeat;
}

- (Seat *)seatForPosition:(SeatPosition)position
{
    return [self.seats objectForKey:@(position)];
}


// MARK: Views

+ (CGRect)initialFrameForCardWithWidth:(CGFloat)width cardHeight:(CGFloat)height atSeat:(Seat *)seat
{
    CGFloat cardWidth = width;
    CGFloat cardHeight = height;
    CGPoint screenCenter = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
    
    CGRect frame = CGRectMake(0, 0, cardWidth, cardHeight);
    
    switch (seat.position) {
        case North: case South:
            frame.origin.x = (screenCenter.x-cardWidth/2);
            break;
        case East: case West:
            frame.origin.y = (screenCenter.y - cardHeight/2);
            break;
    }
    
    switch (seat.position) {
        case North: frame.origin.y = -cardHeight; break;
        case South: frame.origin.y = CGRectGetMaxY([UIScreen mainScreen].bounds); break;
        case East:  frame.origin.x = CGRectGetMaxX([UIScreen mainScreen].bounds); break;
        case West:  frame.origin.x = -cardWidth; break;
    }
    
    return frame;
}

+ (CardFlipDirection)flipDirectionForSeat:(Seat *)seat
{
    switch (seat.position) {
        case North: return FromBottom;
        case South: return FromTop;
        case East:  return FromRight;
        case West:  return FromLeft;
    }
    
    return FromLeft;
}


@end
