//
//  ViewController.m
//  TableCatalog
//
//  Created by Dylan Eirinberg on 8/6/13.
//  Copyright (c) 2013 Dylan Eirinberg. All rights reserved.
//

#import "ViewController.h"
#import "ImageDownloader.h"
#import "Reachability.h"
#import "DivisionsViewController.h"
#import "SettingsViewController.h"
#import "Group.h"
#import "Team.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /* Makes tableView the current delagate and data source of the ViewController so the tableView methods format it.
     * The size of the tableView is set to the screen size (other than 29 pixels allocated to the segmentedcontrol). This 
     * way the tableView will take up the size of both the 3.5 and 4 inch iPhone screens. The tableView shouldn't scroll 
     * since there are few cells for this ViewController and no alert has been shown so both properties are set to no.
     */
    CGRect screen = [UIScreen mainScreen].bounds;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.frame = CGRectMake(0, 29, screen.size.width, screen.size.height-29);
    self.tableView.scrollEnabled = NO;
    self.alertShown = NO;
    
    /* The group entries are set here through a local JSON file. Each entry of the array returns an instancetype 
     * defined in the Group class. The data is converted to group objects using an NSDictionary
     * This array can also be set/initialized in the AppDelegate.
     */
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Groups" ofType:@"JSON"];
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSArray *groupsArray = [dataDictionary objectForKey:@"groups"];
    
    NSMutableArray *mutableGroups = [NSMutableArray array];
    for(NSDictionary *dictionary in groupsArray){
        Group *group = [Group groupWithName:[dictionary objectForKey:@"name"] type:[dictionary objectForKey:@"type"] imgLink:[dictionary objectForKey:@"imgLink"]];
            [mutableGroups addObject:group];
    }
    self.groups = [mutableGroups copy];
    
    /* A settings button (custom type) is set with an image and to the right bar button item of the navigation bar. It is
     * linked up to a method "settingsPressed" to call a segue.
     */
    UIButton *settings = [UIButton buttonWithType:UIButtonTypeCustom];
    [settings setImage:[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal];
    [settings addTarget:self action:@selector(settingsPressed) forControlEvents:UIControlEventTouchUpInside];
    [settings sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settings];

    /* If leagueNames, an array passed from the SettingsViewController, is filled and passed over to this ViewController,
     * the count will be a positive number (not zero). The segmentedControl segments will be iterated through and set
     * to the order of the user defined leagueNames. If there are zero leagueNames entries the default storyboard values
     * will be loaded.
     */
    if([self.leagueNames count] != 0){
        for(int i = 0; i<self.segmentedControl.numberOfSegments; i++){
            [self.segmentedControl setTitle:[self.leagueNames objectAtIndex:i] forSegmentAtIndex:i];
        }
    }
    
    /* To load the current teams it is initialized as an NSMutableArray and segmentedControlSelectedIndexChanged is
     * called so the currTeams and other properties can be set.
     */
    self.currTeams = [[NSMutableArray alloc] init];
    [self segmentedControlSelectedIndexChanged:self];
    
    
    /* The back button for subsequent navigation controller view controllers needs to be formatted here so the text is
     * set to "Back"
     */
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style: UIBarButtonItemStyleBordered target: nil action: nil];
    [[self navigationItem] setBackBarButtonItem:back];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    /* Before this View Controller switches to another View Controller properties need to be passed over.
     * The View Controller that is being transitioned to is determined by the segue.identifier. The
     * DivisionsViewController needs the groups, teams, name of conference, title image and if an Internet alert has
     * shown and what property the cells should sort by.
     */
    if ([segue.identifier isEqualToString:@"mainToDivisions"]){
        DivisionsViewController *destinationController = segue.destinationViewController;
        destinationController.groups = self.groupsToSend;
        destinationController.teams = self.currTeams;
        destinationController.conference = self.selectedConference;
        destinationController.titleImage = self.imageToSend;
        destinationController.alertShown = self.alertShown;
        destinationController.sortBy = self.sortBy;
    }
    /* The SettingsViewController has a tableView to sort the segmentedControl order. The current segmentedControl
     * order is determined by iterating through the segments and passing the data over. Because SettingsViewController
     * is part of a different navigationController the instance to it is found similar to the AppDelegate method.
     * Then it's properties can be properly set.
     */
    else if([segue.identifier isEqualToString:@"mainToSettings"]){
        self.leagueNames = [[NSMutableArray alloc] init];
        for(int i = 0; i<self.segmentedControl.numberOfSegments; i++){
            [self.leagueNames addObject:[self.segmentedControl titleForSegmentAtIndex:i]];
        }
        UINavigationController *navigationController = segue.destinationViewController;
        SettingsViewController *destinationController = [navigationController.viewControllers objectAtIndex:0];
        destinationController.leagueNames = self.leagueNames;
        destinationController.teams = self.teams;
        destinationController.sortBy = self.sortBy;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Calls the mainToSettings segue when the right navigation bar item is set. First it makes sure it exists though.
- (void)settingsPressed {
    if([self shouldPerformSegueWithIdentifier:@"mainToSettings" sender:self]){
        [self performSegueWithIdentifier:@"mainToSettings" sender:self];
    }
}

- (void)segmentedControlSelectedIndexChanged:(id)sender {
    /* The type property holds a shorter name for the segmentedControl title and the title of the navigation bar is set
     * to this league name.
     */
    self.type = [self.segmentedControl titleForSegmentAtIndex:self.segmentedControl.selectedSegmentIndex];
    self.navigationItem.title = self.type;

    //The NSMutableArrays are cleared by removeAllObjects method
    [self.currTeams removeAllObjects];
    [self.currGroups removeAllObjects];

    //Teams are added to the currTeams array if their league property is the selected segment index name
    for(Team *team in self.teams){
        if([team.league isEqualToString:[self.segmentedControl titleForSegmentAtIndex:self.segmentedControl.selectedSegmentIndex]]){
            [self.currTeams addObject:team];
        }
    }
    
    //The tableView then reloads because the league/data has changed
    [self.tableView reloadData];
}

#pragma mark - UITableView data source and delegate methods

/* If there are no entries in the currGroups (which there shouldn't be...they were all removed in the
 * segmentedControlSelectedIndexChanged method before this) the groups will be iterated through. If the
 * group's type (league name) contains the title of selected segmented control index and either the word
 * All or League in it then it is added to currGroups. This way conferences and all teams are added
 * but divisions are discluded. The number of groups is finally returned as the number of table view cells.
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([self.currGroups count] == 0){
        self.currGroups = [[NSMutableArray alloc] init];
        for(Group *group in self.groups){
            if([group.type rangeOfString:self.type].location != NSNotFound && ([group.type rangeOfString:@"All"].location != NSNotFound || [group.type rangeOfString:@"League"].location != NSNotFound)){
                [self.currGroups addObject:group];
            }
        }
    }

    return [self.currGroups count];
}

/* The tableView cells are assigned a height given by remaining screen size divided by the number of rows. 
 * 93 pixels less because of the navigation bar and segmented control heights.
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGRect screen = [UIScreen mainScreen].bounds;
    return (screen.size.height-93)/[self.currGroups count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /* First loads the prototype cells from the identifier CellIdentifier. Font is set and activity disclosure
     * indicator is added.
     */
    static NSString *kCellID = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    /* The current group is linked to the cell at that index. If the cell type has "All" in it. It's image
     * will be set to local image name of that type. If the cell image is of a conference type it's first if
     * the image has been downloaded (stored in cellGroup.logo). If it hasn't and the image link isn't nil.
     * First the internet status is checked to google using the Apple reachability class. If there isn't
     * Internet the alert will be shown. If there is Internet the cell will be set to a default placeholder
     * image and then downloaded using a completion handler. The "NO" parameter in the ImageDownloader 
     * function indicates to that class that this is downloading a cell image and not a full logo image.
     * Finally if none of these parameters is true (imgLink is nil) then the cell image will be set to nil.
     */
        Group *cellGroup = [self.currGroups objectAtIndex:indexPath.row];
        if([cellGroup.type rangeOfString:@"All"].location != NSNotFound){
            NSString *imgPath = [NSString stringWithFormat:@"%@Cell.png", self.type];
            cell.imageView.image = [UIImage imageNamed:imgPath];
        }
        else if(cellGroup.logo) {
            cell.imageView.image = cellGroup.logo;
        }
        else if(![cellGroup.imgLink isEqualToString:@"nil"]){
            Reachability *r = [Reachability reachabilityWithHostName:@"m.google.com"];
            NetworkStatus internetStatus = [r currentReachabilityStatus];
            if(internetStatus == NotReachable){
                if(self.alertShown == NO){
                  UIAlertView *errorAlertView = [[UIAlertView alloc]
                                               initWithTitle:@"No internet connection"
                                               message:@"Images require internet to be downloaded"
                                               delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                  [errorAlertView show];
                    self.alertShown = YES;
                }
            }
            else {
              cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
              ImageDownloader *imageDownloader = [[ImageDownloader alloc] init];
              imageDownloader.group = cellGroup;
            
              [imageDownloader setCompletionHandler:^{
                // Display the newly loaded image
                cell.imageView.image = cellGroup.logo;
              }];
              [imageDownloader startDownload:NO];
            }
        }
        else {
            cell.imageView.image = nil;
        }
    
    /* If the group's type has All or League in it (MLB) the cell name will be set to the normal group name. However,
     * if the cell doesn't have these parameters "Conference" is added after the name to the cell text.
     */
        if([cellGroup.type rangeOfString:@"All"].location != NSNotFound || [cellGroup.name rangeOfString:@"League"].location != NSNotFound){
            cell.textLabel.text = cellGroup.name;
        }
        else {
            cell.textLabel.text = [NSString stringWithFormat:@"%@ Conference", cellGroup.name];
        }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /* The cell is found at the indexpath of the tableView. The selectedConference is set to the cell text so
     * it can be passed over in a segue. The groupsToSend mutable array is cleared and the imageToSend is
     * set to the current cell image so that can be passed over too. If the cell doesn't have the word
     * "All" in it the groups will be iterated through. The group's type is sepearted into two words-league
     * and conference and stored in variables. If the type is equal to the league and league is not found in
     * the type and the current cell contains the conference type the group will be added. Basically this
     * filters all the divisions to be sent to the next viewController.
     */
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.selectedConference = cell.textLabel.text;
    [cell setSelected:NO animated:NO];

    [self.groupsToSend removeAllObjects];
    self.imageToSend = cell.imageView.image;
    if([cell.textLabel.text rangeOfString:@"All"].location == NSNotFound){
           self.groupsToSend = [[NSMutableArray alloc] init];
        for(Group *group in self.groups){
            NSString *league = [[group.type componentsSeparatedByString:@" "] objectAtIndex:0];
            NSString *conference = [[group.type componentsSeparatedByString:@" "] objectAtIndex:1];
            if([self.type isEqualToString:league] && [conference rangeOfString:@"League"].location == NSNotFound && [cell.textLabel.text rangeOfString:conference].location != NSNotFound){
                [self.groupsToSend addObject:group];
            }
        }
    }
    
    //Finally the mainToDivisions segue is called but first checked to see if it exists
    if([self shouldPerformSegueWithIdentifier:@"mainToDivisions" sender:self]){
        [self performSegueWithIdentifier:@"mainToDivisions" sender:self];
    }
}


@end