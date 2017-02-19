//
//  EMBlueLine.m
//  EasyMetro
//
//  Created by Abhishek Trivedi on 10/05/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EMBlueLine.h"

@implementation EMBlueLine

-(void)initializeStations
{
    /*set line name*/
    _lineName = BLUE_LINE ;
    
    /*add stations*/
    /*Blue Line	–East end, Foot stand, Football stadium, City Centre, Peter Park, Maximus, Rocky Street, Boxers Street, Boxing avenue, West End.	*/
    [self addStationWithName:@"East end" andCode:@"EST"] ;
    [self addStationWithName:@"Foot stand" andCode:@"FOOT"] ;
    [self addStationWithName:@"Football stadium" andCode:@"FTBL"] ;
    [self addStationWithName:@"City Centre" andCode:@"CCNT"] ;
    [self addStationWithName:@"Peter Park" andCode:@"PPRK"] ;
    [self addStationWithName:@"Maximus" andCode:@"MXMS"] ;
    [self addStationWithName:@"Rocky Street" andCode:@"RCKY"] ;
    [self addStationWithName:@"Boxers Street" andCode:@"BXS"] ;
    [self addStationWithName:@"Boxing avenue" andCode:@"BXAV"] ;
    [self addStationWithName:@"West End" andCode:@"WST"] ;
}

@end
