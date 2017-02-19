//
//  EMLine.m
//  EasyMetro
//
//  Created by Abhishek Trivedi on 10/05/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EMLine.h"
#import "EMStation.h"

@interface EMLine ()
-(void)initializeStations ;
@end

@implementation EMLine
@synthesize lineName = _lineName ;

-(id)init
{
    if (self = [super init])
    {
        _stations = [[NSMutableArray alloc] init] ;
        [self initializeStations] ;
    }
    return self ;
}

-(NSArray *)stations 
{
    return [NSArray arrayWithArray:_stations] ;
}

-(void)initializeStations
{
    NSAssert(NO, @"Subclasses need to overwrite this method");
}

-(void)addStationWithName:(NSString *)name andCode:(NSString *)code
{
    EMStation *station = [[EMStation alloc] initStationWith:name andStationCode:code] ;
    [_stations addObject:station] ;
}

-(BOOL)hasStationWithStationCode:(NSString *)code
{
    return [[_stations valueForKey:@"stationCode"] containsObject:code] ;
}

@end
