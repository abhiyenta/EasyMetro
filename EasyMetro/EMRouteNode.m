//
//  EMRouteNode.m
//  EasyMetro
//
//  Created by Abhishek Trivedi on 12/05/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EMRouteNode.h"

@implementation EMRouteNode
@synthesize routeNodePath = _routeNodePath ;
@synthesize routeNodeStation = _routeNodeStation ;

-(id)initWithStation:(EMStation *)station andStationPath:(EMStationPath *)path 
{
    if (self = [super init])
    {
        _routeNodeStation = station ;
        _routeNodePath = path ;
    }
    return self ;
}
@end
