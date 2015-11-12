//
//  LayoutParser.h
//  Snap
//
//  Created by Joey Clover on 12/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SuitedCard.h"


@interface SuitedLayoutParser : NSObject

/** 
    Parses a given layout file into a nested array of boolean by substituting the 
    characters for boolean values.
 
    @return an NSArray<NSArray<NSNumber>>
 */
+ (NSArray *)parseLayoutFile:(NSString *)filename ofType:(NSString *)filetype error:(NSError **)error;

/**
 @return if a suit exists for the given value at the given position on the card
 */
+ (BOOL)suitExistsForValue:(SuitedCardValue)value atPosition:(NSUInteger)position;

@end
