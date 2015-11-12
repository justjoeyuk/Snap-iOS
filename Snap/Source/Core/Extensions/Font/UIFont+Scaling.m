//
//  UIFont+Scaling.m
//  Snap
//
//  Created by Joey Clover on 12/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIFont+Scaling.h"

@implementation UIFont (Scaling)

+ (UIFont *)scaledSystemFontWithSize:(CGFloat)size andScaleFactor:(CGFloat)scaleFactor
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    return [UIFont systemFontOfSize:size * screenSize.width / scaleFactor];
}

+ (UIFont *)standardScaledSystemFont
{
    return [self scaledSystemFontWithSize:[UIFont systemFontSize] andScaleFactor:kStandardScaleFactor];
}

+ (UIFont *)scaledBoldSystemFontWithSize:(CGFloat)size andScaleFactor:(CGFloat)scaleFactor
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    return [UIFont boldSystemFontOfSize:size * screenSize.width / scaleFactor];
}

+ (UIFont *)standardScaledBoldSystemFont
{
    return [self scaledBoldSystemFontWithSize:[UIFont systemFontSize] andScaleFactor:kStandardScaleFactor];
}

@end