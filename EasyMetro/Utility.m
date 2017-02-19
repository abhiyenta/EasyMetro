//
//  Utility.m
//  EasyMetro
//
//  Created by Abhishek Trivedi on 13/05/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+ (UIColor *)colorForLine:(NSString *)string
{
    UIColor *color = [UIColor brownColor] ;
    if ([string isEqualToString:RED_LINE])
    {
        color = [UIColor redColor] ;
    }
    else if ([string isEqualToString:BLACK_LINE])
    {
        color = [UIColor blackColor] ;
    }
    else if ([string isEqualToString:GREEN_LINE])
    {
        color = [UIColor greenColor] ;
    }
    else if ([string isEqualToString:YELLOW_LINE])
    {
        color = [UIColor yellowColor] ;
    }
    else if ([string isEqualToString:BLUE_LINE])
    {
        color = [UIColor blueColor] ;
    }
    return color ;
}

+ (NSString *)getSubstringInBracketsFrom:(NSString *)input
{
    NSString *output = nil ;

    NSPredicate *regex1 = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",@"["];
    NSPredicate *regex2 = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",@"]"];
    if([regex1 evaluateWithObject:input] == YES && [regex2 evaluateWithObject:input] == YES)
    {
        NSScanner *scanner = [NSScanner scannerWithString:input] ;
        while ([scanner isAtEnd] == NO)
        {
            [scanner scanUpToString:@"[" intoString:NULL] ;
            [scanner scanString:@"[" intoString:NULL];
            [scanner scanUpToString:@"]" intoString:&output];
        }
    }
    return output ;
}

@end
