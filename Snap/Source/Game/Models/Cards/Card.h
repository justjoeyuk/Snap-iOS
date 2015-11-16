//
//  Card.h
//  Snap
//
//  Created by Joey Clover on 11/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CardFlipDirection) {
    FromOpposite,
    FromBottom,
    FromTop,
    FromLeft,
    FromRight
};

typedef NS_ENUM(NSUInteger, CardFace) {
    Front,
    Back,
};


/** Represents a Card in a game of Snap. */
@protocol Card

/**
 The numeric identifier is the number that will be used to
 verify if the previous card matches the next card the player 
 will see. If the two numeric identifiers match, the cards are considered 
 the same.
 */
- (NSUInteger)numericIdentifier;

@end