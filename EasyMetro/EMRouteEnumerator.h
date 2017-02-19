//
//  EMRouteEnumerator.h
//  EasyMetro
//
//  Created by Abhishek Trivedi on 12/05/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMRouteEnumerator : NSObject 
{
    int current ;
    int length ; 
    NSArray *route ;
}
- (id)initWithRoute:(NSArray *)route ;
- (NSArray *)allObjects ;
- (id)nextObject ;
@end
