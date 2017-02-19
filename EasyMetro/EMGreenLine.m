//
//  EMGreenLine.m
//  EasyMetro
//
//  Created by Abhishek Trivedi on 10/05/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EMGreenLine.h"

@implementation EMGreenLine

-(void)initializeStations
{    
    /*set line name*/
    _lineName = GREEN_LINE ;
    
    /*add stations*/
    /*Green Line- North Pole, Sheldon Street, Greenland City Centre, Stadium House, Green House, Green Cross, South Pole, South Park*/	
    [self addStationWithName:@"North Park" andCode:@"NTHP"] ;
    [self addStationWithName:@"Sheldon Street" andCode:@"SLDS"] ;
    [self addStationWithName:@"Greenland" andCode:@"GRNL"] ;
    [self addStationWithName:@"City Centre" andCode:@"CCNT"] ;
    [self addStationWithName:@"Stadium House" andCode:@"STDH"] ;
    [self addStationWithName:@"Green House" andCode:@"GRNH"] ;
    [self addStationWithName:@"Green Cross" andCode:@"GRNC"] ;
    [self addStationWithName:@"South Pole" andCode:@"STP"] ;
    [self addStationWithName:@"South Park" andCode:@"STHP"] ;
}

@end
