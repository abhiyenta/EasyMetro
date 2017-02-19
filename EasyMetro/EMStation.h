//
//  EMStation.h
//  EasyMetro
//
//  Created by Abhishek Trivedi on 10/05/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMStation : NSObject
{
    /**
     A unique station code.
     */
    NSString *_stationCode ;
    
    /** 
     Station name.
     */
    NSString *_stationName ;
}
@property (nonatomic,readonly) NSString *stationName ;
@property (nonatomic,readonly) NSString *stationCode ;

-(id)initStationWith:(NSString *)name andStationCode:(NSString *)code ;
+ (EMStation *)stationWithCode:(NSString *)stationCode ;
@end
