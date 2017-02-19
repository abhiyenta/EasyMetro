//
//  EMYellowLine.m
//  EasyMetro
//
//  Created by Abhishek Trivedi on 10/05/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EMYellowLine.h"

@implementation EMYellowLine

-(void)initializeStations
{
    /*set line name*/
    _lineName = YELLOW_LINE ;
    
    /*add stations*/
    /*Yellow line – Green Cross, Orange Street, Silk Board, Snake Park, Morpheus lane,  Little Street, Cricket Grounds*/
    [self addStationWithName:@"Green Cross" andCode:@"GRNC"] ;
    [self addStationWithName:@"Orange Street" andCode:@"ORGS"] ;
    [self addStationWithName:@"Silk Board" andCode:@"SLKB"] ;
    [self addStationWithName:@"Snake Park" andCode:@"SNKP"] ;
    [self addStationWithName:@"Morpheus lane" andCode:@"MRPL"] ;
    [self addStationWithName:@"Little Street" andCode:@"LITL"] ;
    [self addStationWithName:@"Cricket Grounds" andCode:@"CRKT"] ;
}

@end
