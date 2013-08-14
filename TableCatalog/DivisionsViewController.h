//
//  DivisionsViewController.h
//  TableCatalog
//
//  Created by Dylan Eirinberg on 8/6/13.
//  Copyright (c) 2013 Dylan Eirinberg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Team;

@interface DivisionsViewController : UITableViewController //doesn't need <UITableViewDelegate, UITableViewDataSource> since it's a UITableViewController

@property (nonatomic, retain) NSArray *groups; //holds the list of all divisions/conferences and their information
@property (nonatomic, retain) NSArray *teams; //holds pointers to all of the teams
@property (nonatomic, retain) NSMutableArray *teamsToSend; //holds all of the teams to be sent to a new instance of this view controller if necessary
@property (nonatomic, retain) NSString *conference; //stores the conference name
@property (nonatomic, retain) NSString *sortBy; //stores whether the cells should be sorted by name or champion
@property (nonatomic, retain) Team *teamToSend; //stores an instance to a single team to be sent to the TeamViewController
@property (nonatomic, retain) UIImage *titleImage; //the passed in image to be set as the title view image
@property (nonatomic) BOOL alertShown; //stores whether an Internet alert has been shown or not

@end

