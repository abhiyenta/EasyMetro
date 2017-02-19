//
//  EMStation.m
//  EasyMetro
//
//  Created by Abhishek Trivedi on 10/05/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EMStation.h"

@implementation EMStation
@synthesize stationName = _stationName ;
@synthesize stationCode = _stationCode ;

-(id)initStationWith:(NSString *)name andStationCode:(NSString *)code 
{
    if (self = [super init])
    {
        _stationName = name ; 
        _stationCode = code ;
    }
    return self ;
}

+ (EMStation *)stationWithCode:(NSString *)stationCode
{
    
    EMStation *station = [[EMStation alloc] initStationWith:@"" andStationCode:stationCode];
    return station;
}

/** overridding isEuqal to identify each station by its unique station code. i.e. making it a "value object"*/
- (BOOL)isEqual:(id)other 
{
    if (other == self)
        return YES;
    if (!other || ![other isKindOfClass:[self class]])
        return NO;
    if ([[self stationCode] isEqualToString:[(EMStation *)other stationCode]])
        return YES;
    return NO;
}


@end
