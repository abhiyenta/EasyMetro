//
//  EMRedLine.m
//  EasyMetro
//
//  Created by Abhishek Trivedi on 10/05/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EMRedLine.h"

@implementation EMRedLine

-(void)initializeStations
{
    /*set line name*/
    _lineName = RED_LINE ;
   
    /*add stations*/
    /*Red Line- Matrix Stand, Keymakers Lane, Oracle Lane, Boxing avenue, Cypher lane, Smith lane, Morpheus Lane, Trinity lane, Neo Lane*/	
    [self addStationWithName:@"Matrix Stand" andCode:@"MRTX"] ;
    [self addStationWithName:@"Keymakers Lane" andCode:@"KEYL"] ;
    [self addStationWithName:@"Oracle Lane" andCode:@"ORCL"] ;
    [self addStationWithName:@"Boxing avenue" andCode:@"BXAV"] ;
    [self addStationWithName:@"Cypher lane" andCode:@"CPR"] ;
    [self addStationWithName:@"Smith lane" andCode:@"SMT"] ;
    [self addStationWithName:@"Morpheus Lane" andCode:@"MRPL"] ;
    [self addStationWithName:@"Trinity lane" andCode:@"TRIL"] ;
    [self addStationWithName:@"Neo lane" andCode:@"NEO"] ;
}

@end
