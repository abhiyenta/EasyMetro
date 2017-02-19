
//This file used in project contains modified code from Peter Snyder
//Copyright (c) 2011, Peter Snyder <snyderp@gmail.com>
//All rights reserved.

//
//  EMGraph.m
//  EasyMetro
//
//  Created/Modified by Abhishek Trivedi on 11/05/13.
//

#import "EMGraph.h"

@interface EMGraph ()
-(void)addRoute:(EMStationPath *)route fromStation:(EMStation *)fromStation toStation:(EMStation *)toStation ;
- (id)keyOfSmallestValue:(NSDictionary *)aDictionary withInKeys:(NSArray *)anArray ;
@end

@implementation EMGraph


- (id)init
{
    self = [super init];
    
    if (self) {
        
        stations = [[NSMutableDictionary alloc] init];
        stationRoutes = [[NSMutableDictionary alloc] init];
        route = [[NSMutableArray alloc] init] ;
    }
    
    return self;
}

- (EMStation *)staionInGraphWithIdentifier:(NSString *)anIdentifier
{
    return [stations objectForKey:anIdentifier];
}

-(void)addBiDirectionalRoute:(EMStationPath *)stationRoute fromStation:(EMStation *)fromStation toStation:(EMStation *)toStation
{  
    [self addRoute:stationRoute fromStation:fromStation toStation:toStation];
    [self addRoute:stationRoute fromStation:toStation toStation:fromStation];
}

-(void)addRoute:(EMStationPath *)stationRoute fromStation:(EMStation *)fromStation toStation:(EMStation *)toStation
{
    [stations setObject:fromStation forKey:[fromStation stationCode]] ;
    [stations setObject:toStation forKey:[toStation stationCode]] ;
    
    /**
     if no current route/edge available, add new edge
     */
    if ([stationRoutes objectForKey:[fromStation stationCode]] == nil)
    {
        [stationRoutes setObject:[NSMutableDictionary dictionaryWithObject:stationRoute forKey:[toStation stationCode]] forKey:[fromStation stationCode]] ;
        return ;
    }
    /**
    add this route/edge on existing edges 
     */

    [[stationRoutes objectForKey:[fromStation stationCode]] setObject:stationRoute forKey:[toStation stationCode]] ;
}


- (EMStationPath *)edgeFromStation:(EMStation *)sourceStation toNeighboringStation:(EMStation *)destinationStation
{
    // First check to make sure a station with the identifier of the given source station exists in the graph
    if ( ! [stationRoutes objectForKey:[sourceStation stationCode]]) {
        
        return nil;
        
    } 
    // Next, make sure that there is an edge from the from the given station to the destination station.  If
    // so, return it.  Otherwise, fall back on the returned nil
    return [[stationRoutes objectForKey:[sourceStation stationCode]] objectForKey:[destinationStation stationCode]];
}

- (NSNumber *)weightFromStation:(EMStation *)sourceStation toNeighboringStation:(EMStation *)destinationStation
{
    EMStationPath *graphEdge = [self edgeFromStation:sourceStation toNeighboringStation:destinationStation];
    
    return (graphEdge) ? graphEdge.weight : nil;
}

- (NSInteger)edgeCount
{
    NSInteger edgeCount = 0;
    
    for (NSString *stationIdentifier in stationRoutes) {
        
        edgeCount += [(NSDictionary *)[stationRoutes objectForKey:stationIdentifier] count];        
    }
    
    return edgeCount;
}

- (NSSet *)neighborsOfStation:(EMStation *)aStation
{
    NSDictionary *edgesFromStation = [stationRoutes objectForKey:[aStation stationCode]];
    
    // If we don't have any record of the given station in the collection, determined by its identifier,
    // return nil
    if (edgesFromStation == nil) {
        
        return nil;
        
    } 
    NSMutableSet *neighboringStations = [NSMutableSet set];
    
    // Otherwise, iterate over all the keys (identifiers) of stations receiving edges
    // from the given station, retreive their coresponding station object, add it to the
    // set, and return the completed set
    for (NSString *neighboringStationIdentifier in edgesFromStation) {
        
        [neighboringStations addObject:[stations objectForKey:neighboringStationIdentifier]];
    }
    
    return neighboringStations;
}

- (NSSet *)neighborsOfStationWithIdentifier:(NSString *)aStationIdentifier
{    
    EMStation *identifiedStation = [stations objectForKey:aStationIdentifier];
    
    return (identifiedStation == nil) ? nil : [self neighborsOfStation:identifiedStation];    
}




// Returns the quickest possible path between two stations, using Dijkstra's algorithm
// http://en.wikipedia.org/wiki/Dijkstra's_algorithm
- (NSArray *)calculateShortRouteFrom:(EMStation *)startStation to:(EMStation *)endStation;
{
    NSMutableDictionary *unexaminedStations = [NSMutableDictionary dictionaryWithDictionary:stations];
    
    // The shortest yet found distance to the origin for each station in the graph.  If we haven't
    // yet found a path back to the origin from a station, or if there isn't one, mark with -1 
    // (which is used equivlently to how infinity is used in some Dijkstra implementations)
    NSMutableDictionary *distancesFromSource = [NSMutableDictionary dictionaryWithCapacity:[unexaminedStations count]];
    
    // A collection that stores the previous station in the quickest path back to the origin for each
    // examined station in the graph (so you can retrace the fastest path from any examined station back
    // looking up the value that coresponds to any station identifier.  That value will be the previous
    // station in the path
    NSMutableDictionary *previousStationInOptimalPath = [NSMutableDictionary dictionaryWithCapacity:[unexaminedStations count]];
    
    // Since NSNumber doesn't have a state for infinitiy, but since we know that all weights have to be
    // positive, we can treat -1 as infinity
    NSNumber *infinity = [NSNumber numberWithInt:-1];
    
    // Set every station to be infinitely far from the origin (ie no path back has been found yet).
    for (NSString *stationIdentifier in unexaminedStations) {
        
        [distancesFromSource setValue:infinity
                               forKey:stationIdentifier];
    }
    
    // Set the distance from the source to itself to be zero
    [distancesFromSource setValue:[NSNumber numberWithInt:0]
                           forKey:startStation.stationCode];
    
    NSString *currentlyExaminedIdentifier = nil;
    
    while ([unexaminedStations count] > 0) {
        
        // Find the station, of all the unexamined stations, that we know has the closest path back to the origin
        NSString *identifierOfSmallestDist = [self keyOfSmallestValue:distancesFromSource withInKeys:[unexaminedStations allKeys]];
        
        // If we failed to find any remaining stations in the graph that are reachable from the source,
        // stop processing
        if (identifierOfSmallestDist == nil) {
            
            break;            
            
    } 
        EMStation *stationMostRecentlyExamined = [stations objectForKey:identifierOfSmallestDist];
        
        // If the next closest station to the origin is the target station, we don't need to consider any more
        // possibilities, we've already hit the shortest distance!  So, we can remove all other 
        // options from consideration.
        if ([identifierOfSmallestDist isEqualToString:[endStation stationCode]]) {
            
            currentlyExaminedIdentifier = [endStation stationCode] ;
            break;
            
        } 
        // Otherwise, remove the station thats the closest to the source and continue the search by looking
        // for the next closest item to the orgin. 
        [unexaminedStations removeObjectForKey:identifierOfSmallestDist];
        
        // Now, iterate over all the stations that touch the one closest to the graph
        for (EMStation *neighboringStation in [self neighborsOfStationWithIdentifier:identifierOfSmallestDist]) {
            
            // Calculate the distance to the origin, from the neighboring station, through the most recently
            // examined station.  If its less than the shortest path we've found from the neighboring station
            // to the origin so far, save / store the new shortest path amount for the station, and set
            // the currently being examined station to be the optimal path home
            // The distance of going from the neighbor station to the origin, going through the station we're about to eliminate
            NSNumber *alt = [NSNumber numberWithFloat:
                             [[distancesFromSource objectForKey:identifierOfSmallestDist] floatValue] +
                             [[self weightFromStation:stationMostRecentlyExamined toNeighboringStation:neighboringStation] floatValue]];
            
            NSNumber *distanceFromNeighborToOrigin = [distancesFromSource objectForKey:[neighboringStation stationCode]];
            
            // If its quicker to get to the neighboring station going through the station we're about the remove 
            // than through any other path, record that the station we're about to remove is the current fastes
            if ([distanceFromNeighborToOrigin isEqualToNumber:infinity] || [alt compare:distanceFromNeighborToOrigin] == NSOrderedAscending) {
                
                [distancesFromSource setValue:alt forKey:[neighboringStation stationCode]];
                [previousStationInOptimalPath setValue:stationMostRecentlyExamined forKey:[neighboringStation stationCode]];
            }
        }                
    }
    
    // There are two situations that cause the above loop to exit,
    // 1. We've found a path between the origin and the destination station, or
    // 2. there are no more possible routes to consider to the destination, in which case no possible
    // solution / route exists.
    //
    // If the key of the destination station is equal to the station we most recently found to be in the shortest path 
    // between the origin and the destination, we're in situation 2.  Otherwise, we're in situation 1 and we
    // should just return nil and be done with it
    if ( currentlyExaminedIdentifier == nil || ! [currentlyExaminedIdentifier isEqualToString:[endStation stationCode]]) {
        
        return nil;
        
    }
    [route removeAllObjects] ;
    // If we did successfully find a path, create and populate a route object, describing each step
    // of the path.
    
    // We do this by first building the route backwards, so the below array with have the last step
    // in the route (the destination) in the 0th position, and the origin in the last position
    NSMutableArray *stationsInRouteInReverseOrder = [NSMutableArray array];
    
    [stationsInRouteInReverseOrder addObject:endStation];
    
    EMStation *lastStepStation = endStation;
    EMStation *previousStation;
    
    while ((previousStation = [previousStationInOptimalPath objectForKey:lastStepStation.stationCode])) {
        
        [stationsInRouteInReverseOrder addObject:previousStation];
        lastStepStation = previousStation;
    }
    
    // Now, finally, at this point, we can reverse the array and build the complete route object, by stepping through 
    // the stations and piecing them togheter with their routes
    NSUInteger numStationsInPath = [stationsInRouteInReverseOrder count];
    for (int i = numStationsInPath - 1; i >= 0; i--) {
        
        EMStation *currentGraphStation = [stationsInRouteInReverseOrder objectAtIndex:i];
        EMStation *nextGraphStation = (i - 1 < 0) ? nil : [stationsInRouteInReverseOrder objectAtIndex:(i - 1)];
        
        EMStationPath *stationRoute = [self edgeFromStation:currentGraphStation toNeighboringStation:nextGraphStation] ;
        
        EMRouteNode *currentNode = [[EMRouteNode alloc] initWithStation:currentGraphStation andStationPath:stationRoute] ;
        [route addObject:currentNode] ;
    }
    
    return route;
}

- (id)keyOfSmallestValue:(NSDictionary *)aDictionary withInKeys:(NSArray *)anArray
{
    id keyForSmallestValue = nil;
    NSNumber *smallestValue = nil;
    
    NSNumber *infinity = [NSNumber numberWithInt:-1];
    
    for (id key in anArray) {
        
        // Check to see if we have or proxie for infinity here.  If so, ignore this value
        NSNumber *currentTestValue = [aDictionary objectForKey:key];
        
        if ( ! [currentTestValue isEqualToNumber:infinity]) {
            
            if (smallestValue == nil || [smallestValue compare:currentTestValue] == NSOrderedDescending) {
                
                keyForSmallestValue = key;
                smallestValue = currentTestValue;
            }
        }
    }
    
    return keyForSmallestValue;
}



@end
