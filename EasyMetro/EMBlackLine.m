//
//  EMBlackLine.m
//  EasyMetro
//
//  Created by Abhishek Trivedi on 10/05/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EMBlackLine.h"

@implementation EMBlackLine

-(void)initializeStations
{
    /*set line name*/
    _lineName = BLACK_LINE ;
    
    /*add stations*/
    /*Black line – East end, Gotham street, Batman street, Jokers street, Hawkins street, Da Vinci lane, South Park, Newton bath tub, Einstein lane, Neo lane.*/	
    [self addStationWithName:@"East end" andCode:@"EST"] ;
    [self addStationWithName:@"Gotham street" andCode:@"GOTM"] ;
    [self addStationWithName:@"Batman street" andCode:@"BAT"] ;
    [self addStationWithName:@"Jokers street" andCode:@"JKR"] ;
    [self addStationWithName:@"Hawkins street" andCode:@"HWK"] ;
    [self addStationWithName:@"Da Vinci lane" andCode:@"DVIN"] ;
    [self addStationWithName:@"South Park" andCode:@"STHP"] ;
    [self addStationWithName:@"Newton bath tub" andCode:@"NWTB"] ;
    [self addStationWithName:@"Einstein lane" andCode:@"EINS"] ;
    [self addStationWithName:@"Neo lane" andCode:@"NEO"] ;
}

@end
