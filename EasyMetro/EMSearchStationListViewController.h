//
//  EMSearchStationListViewController.h
//
//  Created by Abhishek Trivedi on 11/05/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EMSearchListProtocol <NSObject>

-(void)searchResultSelected:(NSString *)searchResult ;

@end

@interface EMSearchStationListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
}
@property (nonatomic, weak) UITextField *currentTextFieldForSearch;
- (NSArray *)currentSearchItems ;
- (void)reloadData ;
- (void)clearDataSource ;
- (void)addObjectsToDataSource:(NSString *)string ;

@end

