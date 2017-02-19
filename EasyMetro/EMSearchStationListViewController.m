//
//  EMSearchStationListViewController.m
//
//  Created by Abhishek Trivedi on 11/05/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EMSearchStationListViewController.h"
#import "EMMetroMap.h"
#import <QuartzCore/QuartzCore.h>

@interface EMSearchStationListViewController (){
    
    NSMutableArray *autoCompleteArray ;
    UITableView *searchResultTableView ;
    __weak UITextField *currentTextFieldForSearch;
}
@end

@implementation EMSearchStationListViewController
@synthesize currentTextFieldForSearch ;

- (void)loadView 
{
    [super loadView];

    /**datasource for this class*/
	autoCompleteArray = [[NSMutableArray alloc] init];

	/** Table used to display search results from text field*/
	searchResultTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
	[searchResultTableView setDelegate:self] ;
	[searchResultTableView setDataSource:self] ;
	[searchResultTableView setScrollEnabled:YES] ;
	[searchResultTableView setRowHeight:SEARCH_TABLE_HEIGHT];
    [[searchResultTableView layer] setCornerRadius:ROUTE_TABLE_CORNER_RADIOUS] ;
	self.view = searchResultTableView;
}

- (NSArray *)currentSearchItems 
{
    return [NSArray arrayWithArray:autoCompleteArray] ;
}

- (void)addObjectsToDataSource:(NSString *)string 
{
    [autoCompleteArray addObject:string] ;
}

- (void)clearDataSource 
{
    [autoCompleteArray removeAllObjects] ;
}

-(void)reloadData 
{
    [searchResultTableView reloadData] ;
}

#pragma mark UITableViewDelegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section 
{

	//Resize table for elements
    CGRect tableViewRect = searchResultTableView.frame ;

    
	if ([autoCompleteArray count] >=3) 
    {
        tableViewRect.size.height = SEARCH_TABLE_HEIGHT*4 ;
        searchResultTableView.frame = tableViewRect ;
        return autoCompleteArray.count ;
	}
	
	else if ([autoCompleteArray count] == 2)
    {
        tableViewRect.size.height = SEARCH_TABLE_HEIGHT*2 ;
        searchResultTableView.frame = tableViewRect ;
        return [autoCompleteArray count] ;
	}	

    tableViewRect.size.height = SEARCH_TABLE_HEIGHT ;
    searchResultTableView.frame = tableViewRect ;
    return [autoCompleteArray count] ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = nil;
	static NSString *identifer = SEARCH_TABLE_CELL_IDENTIFIER;
	cell = [tableView dequeueReusableCellWithIdentifier:identifer];
	if (cell == nil)
    {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer] ;
	}
		
	[[cell textLabel] setText:[autoCompleteArray objectAtIndex:[indexPath row]]];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
	[currentTextFieldForSearch setText:[[selectedCell textLabel] text]];
    [self.view removeFromSuperview] ;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
