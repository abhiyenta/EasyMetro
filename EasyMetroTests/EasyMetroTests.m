//
//  EasyMetroTests.m
//  EasyMetroTests
//
//  Created by Abhishek Trivedi on 10/05/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EasyMetroTests.h"

@implementation EasyMetroTests

- (void)setUp
{
    [super setUp];
    metroMap = [[EMMetroMap alloc] init] ;
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

#pragma mark Model Testing
/** current given map has 38 station total*/
- (void)testMetroMapInitialization
{
    STAssertTrue([[metroMap allStations] count] == 38, @"Invald number of stations in current map, should be greater then 38, not %d", [[metroMap allStations] count]);
}

/** e.g. City Center is at Blue line and Green Line*/
-(void)testLinesFromStationCode
{
    STAssertTrue([[metroMap linesForStationCode:@"CCNT"] count] == 2, @"Invalied number of lines should be 2 and not %d", [[metroMap linesForStationCode:@"CCNT"] count]);
}

/** If I want to travel from East end to Peter Park then  
    Time it would take – 5 * 4 = 20 minutes.  
    Cost – 1 * 4 = 4 $   
    Path   Take  blue  line  at  East  end  going  through  Foot  stand,  Football  stadium,  City  Centre to reach at City Centre.	*/

/** Test "East End" to "Peter Park" scenario */
-(void)testEastEndToPeterPark
{
    [metroMap shortRouteFrom:@"EST" toStation:@"PPRK"] ;
    STAssertTrue(4 == ([[metroMap route] count] - 1), @"Invalid route stations for route, should be 4, not %d", ([[metroMap route] count] - 1));
    
    STAssertTrue(20 == ([[metroMap route] count] - 1) * PER_STATION_TIME, @"Invalid taken, should be 20 minutes, not %d minutes", ([[metroMap route] count] - 1) * PER_STATION_TIME);

    STAssertTrue(4 == ([[metroMap route] count] - 1) * PER_STATION_FARE, @"Invalid fare/cost, should be $4, not $%d", ([[metroMap route] count] - 1) * PER_STATION_FARE);
}
 


/**If I want to travel from Green Cross to Neo Lane.  
    Time it would take = 5 * 5 = 25 minutes.  
    Cost = 5 * 1 + 1 (line	hange) = 6$. 
    Path   Take green line at Green cross moving towards south park, at south park change  to black line and move towards Neo lane.  */  
-(void)testGreenCrossToNeoLane
{
    [metroMap shortRouteFrom:@"GRNC" toStation:@"NEO"] ;
    STAssertTrue(5 == ([[metroMap route] count] - 1), @"Invalid route stations for route, should be 6, not %d", ([[metroMap route] count] - 1));
    
    STAssertTrue(25 == ([[metroMap route] count] - 1) * PER_STATION_TIME, @"Invalid taken, should be 25 minutes, not %d minutes", ([[metroMap route] count] - 1) * PER_STATION_TIME);
    
    int totalFare = ([[metroMap route] count] - 1) ;   
    int lineSwitchCharge = [[NSSet setWithArray:[metroMap lineInfoForCurrentRoute]] count] ;
    if (lineSwitchCharge > 1) 
    {
        totalFare = (totalFare + (lineSwitchCharge - 2)) ;
    }
    STAssertTrue(6 == totalFare * PER_STATION_FARE, @"Invalid fare/cost, should be $6, not $%d", totalFare);
}



/**If you want to travel from Stadium house to East end   
    Time  -­‐ 4 * 5 = 20 mins  
    Cost – 4*1 + 1(line change at City centre) = 5$  
    Path  Take  green  line  at  Stadium  House  moving  towards  North  Park.  Get  down  at  City  centre and take Blue line moving towards East end.	*/
-(void)testStadiumHouseToEastEnd
{
    [metroMap shortRouteFrom:@"STDH" toStation:@"EST"] ;
    STAssertTrue(4 == ([[metroMap route] count] - 1), @"Invalid route stations for route, should be 4, not %d", ([[metroMap route] count] - 1));
    
    STAssertTrue(20 == ([[metroMap route] count] - 1) * PER_STATION_TIME, @"Invalid taken, should be 20 minutes, not %d minutes", ([[metroMap route] count] - 1) * PER_STATION_TIME);
    
    int totalFare = ([[metroMap route] count] - 1)  ;   
    int lineSwitchCharge = [[NSSet setWithArray:[metroMap lineInfoForCurrentRoute]] count] ;
    if (lineSwitchCharge > 1) 
    {
        totalFare = (totalFare + (lineSwitchCharge - 2)) ;
    }
    STAssertTrue(5 == totalFare * PER_STATION_FARE, @"Invalid fare/cost, should be $5, not $%d", totalFare * PER_STATION_FARE);
}

@end
