//
//  NSString+Whitespace.m
//  Snap
//
//  Created by Joey Clover on 12/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

#import "NSString+Whitespace.h"

@implementation NSString (Whitespace)

- (NSString *)stringByStrippingWhitespace
{
    return [[self stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

@end
