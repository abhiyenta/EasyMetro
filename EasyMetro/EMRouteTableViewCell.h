//
//  EMRouteTableViewCell.h
//  EasyMetro
//
//  Created by Abhishek Trivedi on 12/05/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMRouteTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *stopImageView;

@property (weak, nonatomic) IBOutlet UIImageView *lineInfoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *lineInfoLowerHalfImage;
@property (weak, nonatomic) IBOutlet UIImageView *lineInfoUpperHalfImage;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *routeInfoLabel;
@end
