//
//  ViewController.h
//  TableCatalog
//
//  Created by Dylan Eirinberg on 8/6/13.
//  Copyright (c) 2013 Dylan Eirinberg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Team; //forward declaration of the Team class. "Team.h" imported in ViewController.m class.

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> //must have <UITableViewDelegate, UITableViewDataSource> for UIViewController classes implementing a UITableView
  
@property (nonatomic, retain) IBOutlet UITableView *tableView; //the main table view for the class
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentedControl; //a segmented bar used to pick what type of league to sort the teams by

@property (nonatomic, retain) NSString *type; //stores the name of the league selected in the segmentedControl
@property (nonatomic, retain) NSArray *groups; //holds the list of all divisions/conferences and their information
@property (nonatomic, retain) NSMutableArray *currGroups; //stores the related divisions/conferences to the selected league
@property (nonatomic, retain) NSArray *teams; //holds pointers to all of the teams, currently created in the AppDelegate
@property (nonatomic, retain) NSMutableArray *currTeams; //stores the related teams to the selected league
@property (nonatomic, retain) NSMutableArray *groupsToSend; //holds all of the sub-groups of the conference to be sent to the DivisionsViewController after a group is selected
@property (nonatomic, retain) UIImage *imageToSend; //holds the image of the selected league/conference cell, which is sent to the DivisionsViewController and put as the titleView Image of the navigation bar
@property (nonatomic, retain) NSString *selectedConference; //holds the text (name) of the selected league/conference cell, which is sent to the DivisionsViewController and put as the title of the navigation bar when there isn't an image

@property (nonatomic, retain) NSString *sortBy; //stores whether the cells should be sorted by name or champion
@property (nonatomic, retain) NSMutableArray *leagueNames; //stores the order of the segementedControl

@property (nonatomic) BOOL alertShown; //when there isn't Internet stores if an alert has been shown or not

-(void)settingsPressed; //called when right navigation bar item is pressed
-(IBAction)segmentedControlSelectedIndexChanged:(id)sender; //called when value of segmented control bar changes

@end
