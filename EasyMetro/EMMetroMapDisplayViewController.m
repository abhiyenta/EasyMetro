//
//  EMMetroMapDisplayViewController.m
//  EasyMetro
//
//  Created by Abhishek Trivedi on 12/05/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EMMetroMapDisplayViewController.h"

@implementation EMMetroMapDisplayViewController
@synthesize mapDisplayWebView;

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
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *mapImagePath = [[NSBundle mainBundle] pathForResource:@"metroMap.png" ofType:nil];
    NSURL *imageURL = [NSURL fileURLWithPath:mapImagePath] ;
    [[self mapDisplayWebView] loadRequest:[NSURLRequest requestWithURL:imageURL]] ;
    
    [[self navigationItem] setTitle:MAP_DISPLAY_VIEW_TITLE] ;
}

- (void)viewDidUnload
{
    [self setMapDisplayWebView:nil];
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
