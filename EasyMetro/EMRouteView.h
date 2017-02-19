//
//  EMRouteView.h
//  EasyMetro
//
//  Created by Abhishek Trivedi on 11/05/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMRouteView : UIView
@property (weak, nonatomic) IBOutlet UILabel *welcomeNoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fareLable;
@property (weak, nonatomic) IBOutlet UITextField *toField;
@property (weak, nonatomic) IBOutlet UITextField *fromField;
@property (weak, nonatomic) IBOutlet UITableView *routeTableVIew;
@property (weak, nonatomic) IBOutlet UIImageView *routeSelctionBacgroundView;
@end
