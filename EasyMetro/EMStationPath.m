//
//  EMStationPath.m
//  EasyMetro
//
//  Created by Abhishek Trivedi on 11/05/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EMStationPath.h"

@implementation EMStationPath
@synthesize weight = _weight ;
@synthesize routePath = _routePath ;

-(id)initRouteWith:(NSString *)path andWeight:(NSNumber *)weight 
{
    if (self = [super init])
    {
        _routePath = path ; 
        _weight = weight ;
    }
    return self ;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"%@,%@", [self routePath], [self weight]];
}

@end
