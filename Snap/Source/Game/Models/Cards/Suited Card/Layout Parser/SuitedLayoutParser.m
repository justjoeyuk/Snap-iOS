//
//  LayoutParser.m
//  Snap
//
//  Created by Joey Clover on 12/11/2015.
//  Copyright © 2015 Just Joey. All rights reserved.
//

#import "SuitedLayoutParser.h"
#import "SuitedLayoutParser_Private.h"


@interface SuitedLayoutParser()

+ (NSArray *)layouts;

@end


@implementation SuitedLayoutParser

+ (BOOL)suitExistsForValue:(SuitedCardValue)value atPosition:(NSUInteger)position;
{
    return [self suitExistsForValue:value atPosition:position forLayouts:[self layouts]];
}

+ (BOOL)suitExistsForValue:(SuitedCardValue)value atPosition:(NSUInteger)position forLayouts:(NSArray *)layouts
{
    if (layouts == nil) { return NO; }
    
    NSInteger correctedValue = value - 1;
    if (correctedValue >= layouts.count || correctedValue < 0) { return NO; }
    
    NSArray *layout = [layouts objectAtIndex:correctedValue];
    BOOL suitAtPosition = [[layout objectAtIndex:position] boolValue];
    
    return suitAtPosition;
}


+ (const NSArray *)layouts
{
    static dispatch_once_t onceToken;
    static const NSArray * layoutArray;
    
    dispatch_once(&onceToken, ^{
        layoutArray = [SuitedLayoutParser parseLayoutFile:@"suited_card_layouts" ofType:@"txt" error:nil];
    });
    
    return layoutArray;
}


+ (NSArray *)parseString:(NSString *)rawString error:(NSError **)error
{
    NSArray *layoutStrings = [rawString componentsSeparatedByString:@"#########"];
    NSMutableArray *fullLayout = [NSMutableArray array];
    
    for (NSString *layoutString in layoutStrings) {
        NSMutableArray *layout = [NSMutableArray array];
        
        if (layoutString.length != 21) {
            NSLog(@"Invalid Layout File. Please ensure the layouts are correct.");
            *error = [NSError errorWithDomain:@"invalid.file" code:6 userInfo:nil];
            
            return nil;
        }
        
        for (int i = 0; i < layoutString.length; i++) {
            unichar character = [layoutString characterAtIndex:i];
            switch (character) {
                case '-':
                    [layout addObject:@(0)];
                    break;
                case 'x':
                    [layout addObject:@(1)];
                    break;
                default: break;
            }
        }
        
        [fullLayout addObject:layout];
    }
    
    return fullLayout;
}


+ (NSString *)stripString:(NSString *)string
{
    return [[string stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}


+ (NSArray *)parseLayoutFile:(NSString *)filename ofType:(NSString *)filetype error:(NSError **)error
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:filename
                                                         ofType:filetype];
    
    return [self parseLayoutFile:filePath error:error];
}

+ (NSArray *)parseLayoutFile:(NSString *)path error:(NSError *__autoreleasing *)error
{
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    NSString* strippedContent = [self stripString:content];
    
    NSArray *layouts = [self parseString:strippedContent error:error];
    return layouts;
}

@end
