//
//  EMMetroMap.h
//  EasyMetro
//
//  Created by Abhishek Trivedi on 11/05/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMGraph.h"
#import "EMStation.h"
#import "EMRedLine.h"
#import "EMGreenLine.h"
#import "EMBlueLine.h"
#import "EMBlackLine.h"
#import "EMYellowLine.h"


#import "EMStation.h"
#import "EMStationPath.h"

#import "EMRouteEnumerator.h"

@interface EMMetroMap : NSObject
{
    /*lines on this map*/
    NSMutableArray *_lines ;
    
    /**all staions on this map*/
    NSMutableArray *_stations ;
    
    /*lines are logically placed in graph structure */
    EMGraph *graph ;
    
    /*current route */
    NSMutableArray *_route ;
    
    /**line change info for current route*/
    NSMutableArray *_lineInfoForCurrentRoute ;
}

-(NSSet*)linesForStationCode:(NSString *)stationCode ;
-(NSArray *)allStations ;
-(NSArray *)route ;
-(NSArray *)lineInfoForCurrentRoute ;

/**utilities*/
-(EMRouteEnumerator *)routeEnumerator ;
-(EMRouteNode *)nextNodeOf:(EMRouteNode *)node ;
-(EMRouteNode *)previousNodeOf:(EMRouteNode *)node ;

-(void)shortRouteFrom:(NSString *)fromCode toStation:(NSString *)toCode ;

@end
