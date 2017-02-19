//
//  EMRouteIterator.m
//  EasyMetro
//
//  Created by Abhishek Trivedi on 12/05/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EMRouteEnumerator.h"

@implementation EMRouteEnumerator

-(id)initWithRoute:(NSArray *)routeArray 
{
    if (self = [super init])
    {
        route = routeArray ;
        length = [route count] ;
    }
    return self ;
}

-(id)nextObject 
{
    if (current < length)
    {
        return [route objectAtIndex:current++] ;
    }
    return nil ;
}

- (NSArray *)allObjects
{
    return route ;
}

@end
