//This file used in project contains modified code from Peter Snyder
//Copyright (c) 2011, Peter Snyder <snyderp@gmail.com>
//All rights reserved.

//
//  EMGraph.h
//  EasyMetro
//
//  Created/Modified by Abhishek Trivedi on 11/05/13.
//  
//

#import <Foundation/Foundation.h>
#import "EMStation.h"
#import "EMStationPath.h"
#import "EMRouteNode.h"

@interface EMGraph : NSObject
{
    /** node of graph */
    NSMutableDictionary *stations ;
    
    /** edge of graph */
    NSMutableDictionary *stationRoutes ;
    
    /** route between given source and destination */
    NSMutableArray *route ;
}
-(void)addBiDirectionalRoute:(EMStationPath *)stationRoute fromStation:(EMStation *)fromStation toStation:(EMStation *)toStation ;
- (NSMutableArray *)calculateShortRouteFrom:(EMStation *)fromStation to:(EMStation *)toStation;
- (EMStation *)staionInGraphWithIdentifier:(NSString *)anIdentifier ;
@end
