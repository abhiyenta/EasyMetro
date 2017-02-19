//
//  EMConstants.h
//  EasyMetro
//
//  Created by Abhishek Trivedi on 12/05/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#ifndef EasyMetro_EMConstants_h
#define EasyMetro_EMConstants_h

/**line names*/
#define RED_LINE    @"Red Line"
#define BLUE_LINE   @"Blue Line"
#define BLACK_LINE  @"Black Line"
#define GREEN_LINE  @"Green Line"
#define YELLOW_LINE @"Yellow Line"

/**screen titles*/
#define APP_TITLE @"Easy Metro"
#define MAP_DISPLAY_VIEW_TITLE @"Metro Map"

/**button titles*/
#define MAP_BUTTON_TITLE    @"Map"
#define ROUTE_BUTTON_TITLE  @"Find Route"

/**custom text display format*/
#define TOTAL_TIME_DISPLAY_FORMAT           @"Duration: %02dh %02dm"
#define EACH_STATION_TIME_DISPLAY_FORMAT    @"%02d:%02d"
#define FARE_DISPLAY_FORMAT                 @"Fare: %d$"
#define ROUTE_DISPLAY_FORMAT                @"%@ [%@]"

/**constant values */
#define PER_STATION_FARE 1
#define PER_STATION_TIME 5

/** GUI placements*/
#define SEARCH_TABLE_HEIGHT 30
#define SEARCH_TABLE_OFFSET 4
#define ROUTE_TABLE_CORNER_RADIOUS 10.0
#define MAP_BUTTON_HEIGHT   30
#define MAP_BUTTON_WIDTH    50

/**cell identifers*/
#define ROUTE_TABLE_CELL_IDENTIFIER     @"EMRouteTableViewCell"
#define SEARCH_TABLE_CELL_IDENTIFIER    @"SearchTableViewCell"

/**wecome note*/
#define WELCOME_NOTE_PLUE_INSTRUCTION  @"Welcome to EasyMetro. \n Enter \"Form\" and \"To\" stations in above text fields and click 'Find Route' button to get fastest route, fare and time between two stations."

/**model  updated notification*/
#define MODEL_UPDATED @"ModelUpdatedNotification"

#endif
