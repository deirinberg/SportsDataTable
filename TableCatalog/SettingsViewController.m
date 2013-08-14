//
//  SettingsViewController.m
//  TableCatalog
//
//  Created by Dylan Eirinberg on 8/10/13.
//  Copyright (c) 2013 Dylan Eirinberg. All rights reserved.
//

#import "SettingsViewController.h"
#import "ViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // makes tableview the delegate and datasource, turns of scrolling and turns editing on (to reorder cells)
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.frame = CGRectMake(151, 95, 149, 306);
    [self.tableView setEditing:YES animated:YES];
    self.tableView.scrollEnabled = NO;
    
    //If cells are already sorted by champion the segmented control should be set to the appropriate index
    if([self.sortBy isEqualToString:@"Champion"]){
        self.segmentedControl.selectedSegmentIndex = 1;
    }
    
    /* A back button is set to the left bar button item (not the back button item) because they are different navigation
     * controllers (because of the modal segue). The back button is linked with the backToMain method when pressed.
     */
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style: UIBarButtonItemStyleBordered target:self action:@selector(backToMain)];
    [[self navigationItem] setLeftBarButtonItem:back];
}

// If the Back button is pressed the settingsToMain segue will be checked then called
-(void)backToMain {
    if([self shouldPerformSegueWithIdentifier:@"settingsToMain" sender:self]){
        [self performSegueWithIdentifier:@"settingsToMain" sender:self];
    }
}

/* Because ViewController is part of a different navigationController the instance to it is found similar to the
 * AppDelegate method. Then it's properties can be properly set. sortBy is set to the segmentControl selected index
 * name.
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"settingsToMain"]){
        UINavigationController *navigationController = segue.destinationViewController;
        ViewController *destinationController = [navigationController.viewControllers objectAtIndex:0];
        destinationController.leagueNames = self.leagueNames;
        destinationController.sortBy = [self.segmentedControl titleForSegmentAtIndex:self.segmentedControl.selectedSegmentIndex];
        destinationController.teams = self.teams;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView data source and delegate methods

//returns the number of leagues
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.leagueNames count];
}

//divides the cells up evenly
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.frame.size.height/([self.leagueNames count]+1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //cells are formatted with reorder control and colored gray
    NSLog(@"cellForRowAtIndexPath");
    static NSString *kCellID = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
    [cell setBackgroundColor:[UIColor colorWithRed:243.0f/255.0f green:243.0f/255.0f blue:243.0f/255.0f alpha:1.0f]];
    cell.showsReorderControl = YES;
    cell.textLabel.text = [self.leagueNames objectAtIndex:indexPath.row];
    
    return cell;
}

//removes the option to delete cells in the tableView
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

//allows cells to be moved
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//reorders cells in tableView
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString *stringToMove = [self.leagueNames objectAtIndex:sourceIndexPath.row];
    [self.leagueNames removeObjectAtIndex:sourceIndexPath.row];
    [self.leagueNames insertObject:stringToMove atIndex:destinationIndexPath.row];
}


@end
