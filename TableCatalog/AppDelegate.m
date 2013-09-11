//
//  AppDelegate.m
//  TableCatalog
//
//  Created by Dylan Eirinberg on 8/6/13.
//  Copyright (c) 2013 Dylan Eirinberg. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "Team.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /* The team entries are intialized here in the AppDelegate (only works if developer knows what index of the
     * navigation controller the view controller is). They can also be set in a ViewController like the groupsArray.
     * Each entry of the array returns an instancetype define in the Team class. The teams are retrieved from a local
     * JSON file. An NSDictionary then creates of team objects from the file and is added to the teamsArray. The
     * NSUserDefaults removed (or cleared) are for team standings. This allows the standings to be refreshed each
     * time the app opens.
     */
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Teams" ofType:@"JSON"];
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSArray *teamsArray = [dataDictionary objectForKey:@"teams"];
    NSMutableArray *mutableTeams = [NSMutableArray array];
    for(NSDictionary *dictionary in teamsArray){
        Team *team = [Team teamWithName:[dictionary objectForKey:@"name"] league:[dictionary objectForKey:@"league"] coach:[dictionary objectForKey:@"coach"] lastChamp:[dictionary objectForKey:@"lastChamp"] division:[dictionary objectForKey:@"division"] hex:[dictionary objectForKey:@"hex"] imgLink:[dictionary objectForKey:@"imgLink"]];
        [mutableTeams addObject:team];
    }
    NSArray *teamArray = [mutableTeams copy];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"NBAStandings"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"NFLStandings"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"MLBStandings"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"NHLStandings"];
    
    // Finds the pointer to the ViewController and sets the property teams to the teamArray just created above.
    UINavigationController *navigationController = (UINavigationController *)[self.window rootViewController];
    ViewController *viewController = [navigationController.viewControllers objectAtIndex:0];
    viewController.teams = teamArray;
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
