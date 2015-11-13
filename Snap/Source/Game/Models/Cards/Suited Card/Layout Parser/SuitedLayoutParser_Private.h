//
//  SuitedCardParser_Private.h
//  Snap
//
//  Created by Joey Clover on 12/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SuitedLayoutParser ()

/**
 Parses a given file (from string) into a nested array of boolean by substituting the
 characters for boolean values.
 
 @return an NSArray<NSArray<NSNumber>>
 */
+ (NSArray *)parseString:(NSString *)rawString error:(NSError **)error;

/**
 Parses a given file (from path) into a nested array of boolean by substituting the
 characters for boolean values.
 
 @return an NSArray<NSArray<NSNumber>>
 */
+ (NSArray *)parseLayoutFile:(NSString *)path error:(NSError **)error;

/**
 @return if a suit exists for the given value at the given position on the card for the given layout
 */
+ (BOOL)suitExistsForValue:(SuitedCardValue)value atPosition:(NSUInteger)position forLayouts:(NSArray *)layouts;

@end