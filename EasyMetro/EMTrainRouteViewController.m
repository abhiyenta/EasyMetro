//
//  EMTrainRouteViewController.m
//  EasyMetro
//
//  Created by Abhishek Trivedi on 11/05/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EMTrainRouteViewController.h"
#import "EMRouteTableViewCell.h"
#import "EMRouteEnumerator.h"
#import "EMMetroMapDisplayViewController.h"
#import "EMSearchStationListViewController.h"
#import "Utility.h"
#import <QuartzCore/QuartzCore.h>

@interface EMTrainRouteViewController (){
    /** model for this class*/
    EMMetroMap *metroMap ;
    
    EMSearchStationListViewController *searchStationListViewController ;
    
    /**stores info about timings per station*/
    NSMutableArray *perStationTimings ;
    
    /**datasource for search tableview for textfield*/
    NSMutableArray *elementArray ;
    NSMutableArray *lowerCaseElementArray ;
    
    /** datasource for main tableView*/
    NSMutableArray *currentRoute ;
    NSMutableArray *lineInfoForCurrentRoute ;
}
@property (weak, nonatomic) IBOutlet UILabel *welcomeNoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fareLable;
@property (weak, nonatomic) IBOutlet UITextField *toField;
@property (weak, nonatomic) IBOutlet UITextField *fromField;
@property (weak, nonatomic) IBOutlet UITableView *routeTableVIew;
@property (weak, nonatomic) IBOutlet UIImageView *routeSelctionBacgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *stationTextFieldBackgroundView;


-(void)setJourneyTime ;
-(void)setJourneyFare ;
-(void)setPerStationTime ;
-(void)removeSearchView ;
-(void)displayAlertWithMessage:(NSString *)alertString ;
-(NSString *)getRouteFromMap ;
@end

@implementation EMTrainRouteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /** setup model component */
    metroMap = [[EMMetroMap alloc] init] ;
    
    /** textField serach datasource*/
    elementArray = [[NSMutableArray alloc] init];
    
    /**keep track of per station timing*/
    perStationTimings = [[NSMutableArray alloc] init] ;
    
    /**datasource for tableView*/
    currentRoute = [[NSMutableArray alloc] init] ;
    lineInfoForCurrentRoute = [[NSMutableArray alloc] init] ;
    
    /** initalizae search controller which helps searching stations */
    searchStationListViewController = [[EMSearchStationListViewController alloc] init] ;
    
    [self performSelector:@selector(initialization) withObject:nil afterDelay:0.0] ;
    
    /**used to be notified when some change happens in model*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modelUpdated:) name:MODEL_UPDATED object:nil] ;
    
    [[self routeTableVIew] registerNib:[UINib nibWithNibName:@"EMRouteTableViewCell" bundle:nil] forCellReuseIdentifier:ROUTE_TABLE_CELL_IDENTIFIER];
    
    [self.view insertSubview:self.stationTextFieldBackgroundView aboveSubview:self.routeTableVIew] ;
    [self.view insertSubview:self.routeSelctionBacgroundView aboveSubview:self.routeTableVIew] ;
}


-(void)initialization
{
    NSArray *stations = [metroMap allStations] ;
    for (EMStation *station in stations)
    {
        NSString *currentElementToSearch = [NSString stringWithFormat:ROUTE_DISPLAY_FORMAT,[station stationName],[station stationCode]] ;
        [elementArray addObject:currentElementToSearch] ;
    }
    
    /** setup view components */
    [[self navigationItem] setTitle:APP_TITLE] ;
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:ROUTE_BUTTON_TITLE style:UIBarButtonItemStyleDone target:self action:@selector(getRoute)] ;
    [[self navigationItem] setRightBarButtonItem:rightBarButton] ;
    [[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]] ;
    [[[self routeTableVIew] layer] setCornerRadius:ROUTE_TABLE_CORNER_RADIOUS] ;
    
    [[self totalTimeLabel] setText:@""] ;
    [[self fareLable] setText:@""] ;
    [[self welcomeNoteLabel] setText:WELCOME_NOTE_PLUE_INSTRUCTION] ;
    [[self welcomeNoteLabel] setTextColor:[UIColor blackColor]] ;

    [[self routeTableVIew] setBackgroundColor:[UIColor groupTableViewBackgroundColor]] ;
    [[self routeTableVIew] setSeparatorStyle:UITableViewCellSeparatorStyleNone] ;
    
    UIButton *mapViewButton = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
    [mapViewButton setBackgroundImage:[UIImage imageNamed:@"barButtonImage.png"] forState:UIControlStateNormal] ;
    [mapViewButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] ;
    [mapViewButton setTitle:MAP_BUTTON_TITLE forState:UIControlStateNormal] ;
    [mapViewButton addTarget:self action:@selector(displayMetroMap) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:mapViewButton] ;
    
    [mapViewButton setTranslatesAutoresizingMaskIntoConstraints:NO] ;
    
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[mapViewButton(height)]|" options:NSLayoutFormatAlignAllCenterX metrics:@{@"height":@(MAP_BUTTON_HEIGHT)} views:@{@"mapViewButton":mapViewButton}] ;
    [self.view addConstraints:verticalConstraints] ;
    
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[mapViewButton(width)]-10-|" options:NSLayoutFormatAlignAllCenterY metrics:@{@"width":@(MAP_BUTTON_WIDTH)} views:@{@"mapViewButton":mapViewButton}] ;
    [self.view addConstraints:horizontalConstraints] ;
    
}

-(void)displayMetroMap{
    EMMetroMapDisplayViewController *mapDisplayViewController = [[EMMetroMapDisplayViewController alloc] initWithNibName:nil bundle:nil] ;
    [[self navigationController] pushViewController:mapDisplayViewController animated:NO] ;
}

-(void)setJourneyTime
{
    /** total journey calculation */
    int totalTimeInMinutes = ([currentRoute count] - 1) * PER_STATION_TIME ;
    int minutesPortion = totalTimeInMinutes % 60 ;
    int hoursPortion = totalTimeInMinutes / 60 ;
    [[self totalTimeLabel] setText:[NSString stringWithFormat:TOTAL_TIME_DISPLAY_FORMAT,hoursPortion,minutesPortion]] ;
}

-(void)setJourneyFare
{
    /** total cost calculation */
    int totalFare = ([currentRoute count] - 1) ;    
    
    /** line switching is not considered for origin line hence - 1*/
    int lineSwitchCharge = [[NSSet setWithArray:lineInfoForCurrentRoute] count] ;
    if (lineSwitchCharge > 1) 
    {
        totalFare = (totalFare + (lineSwitchCharge - 2)) ; 
    }
    
    [[self fareLable] setText:[NSString stringWithFormat:FARE_DISPLAY_FORMAT,totalFare * PER_STATION_FARE ]] ;
}


-(void)setPerStationTime
{
    EMRouteEnumerator *enumerator = [metroMap routeEnumerator] ;
    EMRouteNode *routeNode = nil ;
    int perStationTime = 0 ;
    while (routeNode = [enumerator nextObject])
    {
        /** set per statoin timing */
        [perStationTimings addObject:[NSString stringWithFormat:EACH_STATION_TIME_DISPLAY_FORMAT,perStationTime / 60,perStationTime % 60]] ;
        perStationTime += PER_STATION_TIME ;
    }
}

- (NSString *)getShortRoute:(NSString *)toFieldText fromFieldText:(NSString *)fromFieldText 
{
    if ([fromFieldText length] == 0 || [toFieldText length] == 0)
        return @"\"From: or To:\" Fields Required. Kindly Enter!" ;
    
    NSString *fromCode = [Utility getSubstringInBracketsFrom:fromFieldText] ;
    NSString *toCode = [Utility getSubstringInBracketsFrom:toFieldText] ;
    
    if ([fromCode length] == 0 || [toCode length] == 0)
        return @"No Valid \"From: or To:\" Station Found. Kindly Verify Your Inputs!" ;
    
    //if both stations are same.
    if ([fromCode compare:toCode options:NSCaseInsensitiveSearch] == NSOrderedSame)
        return @"Both Station Are Same. Enter Different Value!" ;
    
    /** ask model for route between stations. This puts its route in "route" instance variable in it*/
    [metroMap shortRouteFrom:fromCode toStation:toCode] ;
    return nil ;
}

-(NSString *)getRouteFromMap
{        
    return [self getShortRoute:[[self fromField] text] fromFieldText:[[self toField] text]];
}


-(void)modelUpdated:(NSNotification *)notifiaction
{
    NSDictionary *route = [notifiaction object] ;
    
    if (!route.count)
    {
        //if route is not found. Reasone could be wrong inputs.
        NSString *alertString = @"Route Not Found. Kindly Verify Your Inputs!" ;       
        [self displayAlertWithMessage:alertString] ;
    }
    [currentRoute removeAllObjects] ;
    [currentRoute addObjectsFromArray:[route objectForKey:@"currentRoute"]] ;
    
    [lineInfoForCurrentRoute removeAllObjects] ;
    [lineInfoForCurrentRoute addObjectsFromArray:[route objectForKey:@"lineInfoForCurrentRoute"]] ;

    [perStationTimings removeAllObjects] ;
    
    /**set time, fare...etc*/
    [self setJourneyTime] ;
    [self setPerStationTime] ;
    [self setJourneyFare] ;
    
    [[self fromField] resignFirstResponder] ;
    [[self toField] resignFirstResponder] ;
    [[self welcomeNoteLabel] setHidden:YES] ;
    [[self routeTableVIew] reloadData] ;
}

-(void)getRoute
{
    /** if route has not been calculated succefully ..show alert*/
    NSString *alertMessage = [self getRouteFromMap];
    if (alertMessage)
    {
        [self displayAlertWithMessage:alertMessage] ;
    }
}

-(void)displayAlertWithMessage:(NSString *)alertString
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:APP_TITLE message:alertString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] ;
    [alert show] ;
}

-(void)removeSearchView
{
    if (![[searchStationListViewController currentSearchItems] containsObject:[[searchStationListViewController currentTextFieldForSearch] text]]) 
    {
        [[searchStationListViewController currentTextFieldForSearch] setText:@""] ;
    }
    [[searchStationListViewController view] removeFromSuperview] ;
}

#pragma mark - TableView Delegates/Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [currentRoute count] ;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EMRouteTableViewCell *cell = (EMRouteTableViewCell *)[tableView dequeueReusableCellWithIdentifier:ROUTE_TABLE_CELL_IDENTIFIER];
    if (cell == nil) 
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:ROUTE_TABLE_CELL_IDENTIFIER owner:nil options:nil] ;
        if ([nib count] == 0)
        {
            NSAssert(NO, @"No nib with cell identifer found") ;  
            return nil ;
        }
        cell = [nib objectAtIndex:0] ;
    } 
        
    /** set line color based on staton*/
    UIColor *lineInfo = [lineInfoForCurrentRoute objectAtIndex:[indexPath row]] ;
    [[cell lineInfoImageView] setBackgroundColor:lineInfo] ;
    
    [[cell lineInfoLowerHalfImage] setBackgroundColor:[UIColor clearColor]] ;
    [[cell lineInfoUpperHalfImage] setBackgroundColor:[UIColor clearColor]] ;
    [[cell stopImageView] setImage:[UIImage imageNamed:@"stop.png"]] ;
    
    /** set station icon */ 
    if ([indexPath row] == 0)
    {
        /** for first and last station I display diffrent icon*/
        [[cell stopImageView] setImage:[UIImage imageNamed:@"startend.png"]] ;
        [[cell lineInfoUpperHalfImage] setBackgroundColor:[UIColor whiteColor]] ;

    }
    else if ([indexPath row] == ([currentRoute count] - 1))
    {
        [[cell stopImageView] setImage:[UIImage imageNamed:@"startend.png"]] ;
        [[cell lineInfoLowerHalfImage] setBackgroundColor:[UIColor whiteColor]] ;
    }
    
    /** but if  we switch line at junction , show junction color*/
    if ([lineInfo isEqual:[UIColor clearColor]])
    {
        int nextObjectIndex = [indexPath row] + 1 ;
        /** add boundry conditions for saftey*/
        if (nextObjectIndex < [lineInfoForCurrentRoute count])
        {
            [[cell lineInfoLowerHalfImage] setBackgroundColor:[lineInfoForCurrentRoute objectAtIndex:nextObjectIndex]] ;
        }
        
        /** add boundry conditions for saftey*/
        int previousObjectIndex = [indexPath row] - 1 ;
        if (previousObjectIndex >= 0)
        {
            [[cell lineInfoUpperHalfImage] setBackgroundColor:[lineInfoForCurrentRoute objectAtIndex:previousObjectIndex]] ;
        }
    }
    
    /**current station on route*/
    EMRouteNode *currentNode = [currentRoute objectAtIndex:[indexPath row]] ;
    EMStation *station = [currentNode routeNodeStation] ;
    
    /** set route info in station [Code] format */
    [[cell routeInfoLabel] setText:[NSString stringWithFormat:ROUTE_DISPLAY_FORMAT,[station stationName],[station stationCode]]] ;
    ;
    
    /** per station time*/
    [[cell timeLabel] setText:[perStationTimings objectAtIndex:[indexPath row]]] ;
    
    return cell ;
}


#pragma mark UITextFieldDelegate methods

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring
{
    
	[searchStationListViewController clearDataSource];
    
	for(NSString *curString in elementArray)
    {
		NSRange range = [curString rangeOfString:substring options:NSCaseInsensitiveSearch] ;
        
		if (range.location != NSNotFound) 
        {
			[searchStationListViewController addObjectsToDataSource:curString];
		}
	}
    [searchStationListViewController view].frame = [self routeTableVIew].frame ;
    [self.view addSubview:[searchStationListViewController view]] ;
	[searchStationListViewController reloadData];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
	[[self view] endEditing:YES] ;
    [self removeSearchView] ;
	[super touchesBegan:touches withEvent:event];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [self removeSearchView] ;
    return YES ;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{    
	BOOL isDone = YES ;
	
	if (isDone)
    {
        [self removeSearchView] ;
		[textField resignFirstResponder] ;
		return YES ;
	} 
    return NO ;
} 

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string 
{    
    CGRect frame = [textField frame] ;
    [searchStationListViewController setCurrentTextFieldForSearch:textField] ;
    [searchStationListViewController view].frame  = CGRectMake(frame.origin.x + SEARCH_TABLE_OFFSET/2, frame.origin.y - SEARCH_TABLE_OFFSET + frame.size.height, frame.size.width - SEARCH_TABLE_OFFSET, 0.0);
	
    NSString *substring = [NSString stringWithString:[textField text]];
	substring = [substring stringByReplacingCharactersInRange:range withString:string];
    
	[self searchAutocompleteEntriesWithSubstring:substring];
	return YES;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MODEL_UPDATED object:nil] ;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
