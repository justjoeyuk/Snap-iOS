//
//  UIFont_Scaling.h
//  Snap
//
//  Created by Joey Clover on 12/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

#import <UIKit/UIKit.h>


static const CGFloat kStandardScaleFactor = 300;


@interface UIFont (Scaling)

/** 
 @returns a system font with a given size that scaled with the screen size
 */
+ (UIFont *)scaledSystemFontWithSize:(CGFloat)size andScaleFactor:(CGFloat)scaleFactor;

/** 
 @returns the value returned by scaledSystemFontWithSize:andScaleFactor using the system font size 
 and the kStandardScaleFactor
 */
+ (UIFont *)standardScaledSystemFont;

@end
