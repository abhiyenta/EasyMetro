//
//  EMStationPath.h
//  EasyMetro
//
//  Created by Abhishek Trivedi on 11/05/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMStationPath : NSObject
{
    /**
     weight is currently 1
     */
    NSNumber *_weight ;
    
    /**show discription about start and end station
     */
    NSString *_routePath ;
}
@property (nonatomic, readonly) NSNumber *weight ;
@property (nonatomic, readonly) NSString *routePath ;

-(id)initRouteWith:(NSString *)path andWeight:(NSNumber *)weight ;

@end
