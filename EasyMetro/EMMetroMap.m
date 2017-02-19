//
//  EMMetroMap.m
//  EasyMetro
//
//  Created by Abhishek Trivedi on 11/05/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EMMetroMap.h"
#import "Utility.h"

@interface EMMetroMap ()
@property(nonatomic,readonly) NSMutableArray *lines ;
-(void)organizeLines ;
-(void)setLineInfo ;
-(void)setLineInfoFor:(EMRouteNode *)currentNode ;
@end
@implementation EMMetroMap

@synthesize lines = _lines ;

-(id)init
{
    if (self = [super init])
    {
        graph = [[EMGraph alloc] init] ; //may consider making this a reference object than value object
        _lines = [[NSMutableArray alloc] init] ;
        _stations = [[NSMutableArray alloc] init] ;
        _route = [[NSMutableArray alloc] init] ;
        _lineInfoForCurrentRoute = [[NSMutableArray alloc] init] ;
        
        /*add lines to map*/
        [_lines addObject:[[EMRedLine alloc] init]] ;
        [_lines addObject:[[EMGreenLine alloc] init]] ;
        [_lines addObject:[[EMYellowLine alloc] init]] ;
        [_lines addObject:[[EMBlackLine alloc] init]] ;
        [_lines addObject:[[EMBlueLine alloc] init]] ;

        [self organizeLines] ;
    }
    return self ;
}

-(void)organizeLines
{
    [_stations removeAllObjects] ;
    for (EMLine *line in _lines) 
    {
        EMStation *lastNode = nil ;
        for (EMStation *currentNode in [line stations])
        {
            if (![_stations containsObject:currentNode]) //since station is value object
            {
                [_stations addObject:currentNode] ;
            }
            if (lastNode)
            {
                EMStationPath *stationRoute = [[EMStationPath alloc] initRouteWith:[NSString stringWithFormat:@"%@-%@",[lastNode stationCode],[currentNode stationCode]] andWeight:[NSNumber numberWithInt:1]] ;
                
                [graph addBiDirectionalRoute:stationRoute fromStation:lastNode toStation:currentNode] ;
            }
            lastNode = currentNode ;
        }
    }
}

-(NSArray *)allStations 
{
    return [NSArray arrayWithArray:_stations] ;
}

-(NSArray *)route 
{
    return [NSArray arrayWithArray:_route] ;
}

-(NSArray *)lineInfoForCurrentRoute 
{
    return [NSArray arrayWithArray:_lineInfoForCurrentRoute] ;
}

-(NSSet *)linesForStationCode:(NSString *)stationCode 
{
    NSMutableSet *lines = [NSMutableSet setWithCapacity:1] ;
    
    for (EMLine *line in _lines)
    {
        if([line hasStationWithStationCode:stationCode])
        {
            [lines addObject:line.lineName] ;
        }
    }
    return [NSSet setWithSet:lines] ;
}

-(EMRouteNode *)nextNodeOf:(EMRouteNode *)node
{
    int currentIndex = [_route indexOfObject:node] ;
    EMRouteNode *nextNode = nil ;
    if (++currentIndex < [_route count])
    {
         nextNode = [_route objectAtIndex:currentIndex] ;
    }
    return nextNode ;
}

-(EMRouteNode *)previousNodeOf:(EMRouteNode *)node
{
    int currentIndex = [_route indexOfObject:node] ;
    EMRouteNode *previousNode = nil ;
    if (--currentIndex >= 0)
    {
        previousNode = [_route objectAtIndex:currentIndex] ;
    }
    return previousNode ;
}

-(EMRouteEnumerator *)routeEnumerator 
{
    EMRouteEnumerator *enumerator = [[EMRouteEnumerator alloc] initWithRoute:_route] ;
    return enumerator ;
}

-(void)shortRouteFrom:(NSString *)fromCode toStation:(NSString *)toCode
{
    [_route removeAllObjects] ;
    [_lineInfoForCurrentRoute removeAllObjects] ;
    //create temp placeholder to station
    int toIndex = [_stations indexOfObject:[EMStation stationWithCode:toCode]] ;
    
    //create temp placeholder to station
    int fromIndex = [_stations indexOfObject:[EMStation stationWithCode:fromCode]] ;
    
    if ((toIndex < _stations.count && fromIndex < _stations.count)) 
    {
        EMStation *toStation = [_stations objectAtIndex:toIndex] ;
        EMStation *fromStation = [_stations objectAtIndex:fromIndex] ;
        NSArray *routeArray = [graph calculateShortRouteFrom:fromStation to:toStation] ;
        [_route addObjectsFromArray:routeArray] ;
    }
    [self setLineInfo] ;
    
    NSDictionary *modelDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithArray:_route], @"currentRoute", [NSArray arrayWithArray:_lineInfoForCurrentRoute], @"lineInfoForCurrentRoute", nil] ;
    //**notifiy interested observers for route update*/
    [[NSNotificationCenter defaultCenter] postNotificationName:MODEL_UPDATED object:modelDictionary] ;
}

-(void)setLineInfo 
{
    EMRouteEnumerator *enumerator = [self routeEnumerator] ;
    EMRouteNode *routeNode = nil ;
    while (routeNode = [enumerator nextObject])
    {
        /**set Line Info*/
        [self setLineInfoFor:routeNode] ;
    }
}

-(void)setLineInfoFor:(EMRouteNode *)currentNode 
{
    /**current station on route*/
    EMStation *station = [currentNode routeNodeStation] ;
    NSSet *currentStationLine = [self linesForStationCode:[station stationCode]] ;
    
    /**previous station on route*/
    EMRouteNode *previousNode = [self previousNodeOf:currentNode] ;
    EMStation *previousStation = [previousNode routeNodeStation] ;
    NSSet *previousStationLine = [self linesForStationCode:[previousStation stationCode]] ;
    
    /**next station on route*/
    EMRouteNode *nextNode = [self nextNodeOf:currentNode] ;
    EMStation *nextStation = [nextNode routeNodeStation] ;
    NSSet *nextStationLine = [self linesForStationCode:[nextStation stationCode]] ;
    
    /** if previous and next stations are same, don't consider it as line switch*/
    NSMutableSet *intersection = [NSMutableSet setWithSet:currentStationLine];
    [intersection intersectSet:previousStationLine];
    [intersection intersectSet:nextStationLine];
    
    if (intersection.count) /** this means next and previous stations are same */
    {
        [_lineInfoForCurrentRoute addObject:[Utility colorForLine:[intersection anyObject]]] ;
        return ;
    }
    else if (currentStationLine.count == 2) /** this means junction point where line changes */
    {
        [_lineInfoForCurrentRoute addObject:[UIColor clearColor]] ;
        return ;
    }
    /** by default current station line */
    [_lineInfoForCurrentRoute addObject:[Utility colorForLine:[currentStationLine anyObject]]] ;
}


@end
