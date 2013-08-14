//
//  DivisionsViewController.m
//  TableCatalog
//
//  Created by Dylan Eirinberg on 8/6/13.
//  Copyright (c) 2013 Dylan Eirinberg. All rights reserved.
//

#import "DivisionsViewController.h"
#import "TeamViewController.h"
#import "Group.h"
#import "Team.h"

@interface DivisionsViewController ()

@end

@implementation DivisionsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //When the view loads if there is a title image it will be resized to fit in the navigation bar and set as the titleView
    if(self.titleImage != nil){
      CGSize itemSize = CGSizeMake(34, 34);
      UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0f);
      CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
      [self.titleImage drawInRect:imageRect];
      self.titleImage = UIGraphicsGetImageFromCurrentImageContext();
      UIGraphicsEndImageContext();
      self.navigationItem.titleView = [[UIImageView alloc] initWithImage:self.titleImage];
    }

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //If the segue is to the TeamViewController the appropriate data is passed in to the class
    if ([segue.identifier isEqualToString:@"divisionsToTeam"]){
        TeamViewController *destinationController = segue.destinationViewController;
        destinationController.team = self.teamToSend;
        destinationController.title = self.teamToSend.name;
        destinationController.alertShown = self.alertShown;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // If there are no groups the teams will be displayed (so the teams count)
    if([self.groups count] == 0){
        return [self.teams count];
    }
    //If there are groups, the count will be one more than the groups (for all conference teams)
    else{
      self.tableView.scrollEnabled = NO;
      return [self.groups count]+1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    /* If there are less than 10 teams to display they will fill the screen evenly.
     * If there are no groups and the teams are sorted by name the size is a fixed 44 pixels.
     * If there are no groups and the teams are sorted by champion the size is a fixed 60 pixels (for the subtitle).
     * Finally if there are groups they will be evenly divided (plus one for all conference cell).
     */
     CGRect screen = [UIScreen mainScreen].bounds;
    if([self.groups count] == 0 && [self.teams count]<10){
        return (screen.size.height-64)/([self.teams count]);
    }
    else if([self.groups count] == 0 && ([self.sortBy isEqualToString:@"Name"] || self.sortBy == nil)){
     return 44;
    }
    else if([self.groups count] == 0){
        return 60;
    }
    else {
     return (screen.size.height-64)/([self.groups count]+1);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /* First loads the prototype cells from the identifier CellIdentifier. Font is set and activity disclosure
     * indicator is added.
     */
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [cell.textLabel setFont:[UIFont boldSystemFontOfSize:17]];
    
    // Cells alternate colors between gray and white
    if(indexPath.row%2==0){
     [cell setBackgroundColor:[UIColor colorWithRed:243.0f/255.0f green:243.0f/255.0f blue:243.0f/255.0f alpha:1.0f]];
    }
    else{
     [cell setBackgroundColor:[UIColor whiteColor]];
    }
    
    /* If there are no groups the teams are sorted by the sortBy string. If the sortBy string is nil (not set) or
     * "Name" the cells will be sorted alphabetically and the cell detailTextLabel will be nothing. If the cells
     * are sorted by champion they won't be ascending (most recent first). The cell name will be associated
     * with the indexPath of the sorted Array. If the cell detailTextLabel isn't nothing the detailTextLabel
     * (subtitle) will be set to the year the team last won the championship. If there are groups. The first
     * row will be set to all teams of the conference. The rest of the rows will be sorted alphabetically
     * with the cell name set to the group name with divison after it.
     */
    if([self.groups count] == 0){
        NSArray *descriptors;
        if(self.sortBy == nil || [self.sortBy isEqualToString:@"Name"]){
            NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
            descriptors = [NSArray arrayWithObject:valueDescriptor];
            cell.detailTextLabel.text = @"";
        }
        else if([self.sortBy isEqualToString:@"Champion"]){
            NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastChamp" ascending:NO];
            descriptors = [NSArray arrayWithObject:valueDescriptor];
        }
        NSArray *sortedTeams = [self.teams sortedArrayUsingDescriptors:descriptors];
        Team *team = [sortedTeams objectAtIndex:indexPath.row];
        cell.textLabel.text = team.name;
        if(![cell.detailTextLabel.text isEqualToString:@""]){
            cell.detailTextLabel.text = [NSString stringWithFormat:@"Last Championship: %@", team.lastChamp];
        }
    }
    
    else {
        if(indexPath.row == 0){
            cell.textLabel.text = [NSString stringWithFormat:@"All %@ Teams", self.conference];
        }
        else {
          NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
          NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
          NSArray *sortedGroups = [self.groups sortedArrayUsingDescriptors:descriptors];
          Group *group = [sortedGroups objectAtIndex:indexPath.row-1];
            cell.textLabel.text = [NSString stringWithFormat:@"%@ Division", group.name];
        }
        cell.detailTextLabel.text = @"";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    /* If there are no groups and a cell is selected a team will be sent to the TeamViewController. The teams are then
     * searched through. When the cell text matches a team name this team will be set to the teamToSend (for the segue).     
     * "break" is used to stop the for loop because once a team is found nothing needs to be searched for any more.
     * Next the divisionsToTeam segue is checked and called.
     */
    if([self.groups count] == 0){
        for(Team *team in self.teams){
            if([cell.textLabel.text isEqualToString:team.name]){
              self.teamToSend = team; break;
            }
        }
        if([self shouldPerformSegueWithIdentifier:@"divisionsToTeam" sender:self]){
            [self performSegueWithIdentifier:@"divisionsToTeam" sender:self];
        }
    }
    /* If there are groups, they will be sent to a new instance of this ViewController. To do this this view
     * is reloaded from the storyboard. teamsToSend is initialized. If the cell has the word "All" in it
     * the groups and teams will be iterated through in a nested for loop. If the team's division is equal
     * to the group's name the team will be added in the teamsToSend array. If the cell name doesn't have
     * "All" in it (the cell is a division) the cell will iterate through the teams and see if its division
     * matches the name of the group and add these teams in teamsToSend. This data will then be passed
     * to a new instance of this class with a push animation.
     */
    else {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DivisionsViewController *childView = [sb instantiateViewControllerWithIdentifier:@"divisionsView"];
        self.teamsToSend = [[NSMutableArray alloc] init];
        if([cell.textLabel.text rangeOfString:@"All"].location != NSNotFound){
          for(Group *group in self.groups){
              for(Team *team in self.teams){
                  if([team.division isEqualToString:group.name]){
                      [self.teamsToSend addObject:team];
                  }
               }
           }
         }
        else{
         for(Team *team in self.teams){
            if([cell.textLabel.text rangeOfString:team.division].location != NSNotFound){
                [self.teamsToSend addObject:team];
            }
         }
        }
        childView.title = cell.textLabel.text;
        childView.teams = self.teamsToSend;
        childView.sortBy = self.sortBy;
        childView.alertShown = self.alertShown;
        childView.groups = nil;
        [self.navigationController pushViewController:childView animated:YES];
    }
}


@end
