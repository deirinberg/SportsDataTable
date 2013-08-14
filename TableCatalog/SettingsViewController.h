//
//  SettingsViewController.h
//  TableCatalog
//
//  Created by Dylan Eirinberg on 8/10/13.
//  Copyright (c) 2013 Dylan Eirinberg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) IBOutlet UITableView *tableView; //tableView to store order of the segmented control
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentedControl; //displays option of sorting teams by name or champion
@property (nonatomic, retain) NSMutableArray *leagueNames; //array of leagues to reorder
@property (nonatomic, retain) NSArray *teams; //because teams are set in the AppDelegate this info needs to be passed into this class so it isn't deleted
@property (nonatomic, retain) NSString *sortBy; //holds type the teams should be sorted by

-(void)backToMain;
@end
