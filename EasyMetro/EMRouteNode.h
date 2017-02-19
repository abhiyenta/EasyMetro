//
//  EMRouteNode.h
//  EasyMetro
//
//  Created by Abhishek Trivedi on 12/05/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMStation.h"
#import "EMStationPath.h"

@interface EMRouteNode : NSObject
{
    /**current station for this node*/
    EMStation *_routeNodeStation ;
    
    /**edge for this node*/
    EMStationPath *_routeNodePath ;
}

@property (nonatomic, readonly) EMStation *routeNodeStation ;
@property (nonatomic, readonly) EMStationPath *routeNodePath ;

-(id)initWithStation:(EMStation *)station andStationPath:(EMStationPath *)path ;
@end
