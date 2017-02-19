//
//  EMRouteTableViewCell.m
//  EasyMetro
//
//  Created by Abhishek Trivedi on 12/05/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EMRouteTableViewCell.h"

@implementation EMRouteTableViewCell

@synthesize stopImageView;
@synthesize lineInfoImageView;
@synthesize lineInfoLowerHalfImage;
@synthesize lineInfoUpperHalfImage;

@synthesize timeLabel;
@synthesize routeInfoLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
