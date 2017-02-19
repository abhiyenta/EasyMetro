//
//  EMLine.h
//  EasyMetro
//
//  Created by Abhishek Trivedi on 10/05/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMLine : NSObject
{
    /**
     Stations of type EMStation on particular line. 
     */
    NSMutableArray *_stations ;
    
    /**
    Line name
     */
    NSString *_lineName ;
    
}

@property (nonatomic,readonly) NSString *lineName ;
-(void)addStationWithName:(NSString *)name andCode:(NSString *)code ;
-(BOOL)hasStationWithStationCode:(NSString *)code ;
-(NSArray *)stations ;
@end
