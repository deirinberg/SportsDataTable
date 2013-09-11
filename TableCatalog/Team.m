//
//  Team.m
//  Simple Table
//
//  Created by Dylan Eirinberg on 7/29/13.
//  Copyright (c) 2013 Dylan Eirinberg. All rights reserved.
//

#import "Team.h"

@implementation Team

/* creates and returns a new team with the passed in properties. The image link is set after content.sportslogos.net where
 * all the logo images I used are stored.
 */
+ (instancetype)teamWithName:(NSString *)name league:(NSString *)league coach:(NSString *)coach lastChamp:(NSString *)lastChamp division:(NSString *)division hex:(NSString *)hex imgLink:(NSString *)imgLink {
    
	Team *newTeam = [[self alloc] init];
    newTeam.name = name;
	newTeam.league = league;
    newTeam.coach = coach;
    newTeam.lastChamp = lastChamp;
    newTeam.division = division;
    newTeam.hex = hex;
    newTeam.imgLink = [NSString stringWithFormat:@"http://content.sportslogos.net%@", imgLink];
    
    /* The following section downloads the HTML of the ESPN standings pages. Some of the teams names do not match up with 
     * ESPN's cities.
     */
    
    //goes to the league page of the team
    NSString *standingsString = [NSString stringWithFormat:@"http://espn.go.com/%@/standings", [league lowercaseString]];
    
    //separates the full team name into an array of words (separated by spaces)
    NSArray *specialCases = [name componentsSeparatedByString:@" "];
    
    //special holds the finalized ESPN city name (initially set to the first word which works for most cases)
    NSString *special = [specialCases objectAtIndex:0];
    
    /* ESPN standings only have the city. If there are 3 words in the name finding the city is complicated. Sometimes
     * the city is two words (ex: Green Bay Packers) and sometimes the team name is two word (ex: Boston Red Sox). This
     * approaches the first scenario. Team names with two words all in the 4 leagues all have Red, Blue or Maple in them
     * (the white sox) are a special case. If the team doesn't have a two word name with one of those words it must have
     * a two word city so the ESPN city name is set to it. If it does have a two word name nothing needs to happen since
     * the special string was initialized to the first word.
     *
     * The following cases are special. The NFL, MLB, and NHL have 2 teams so ESPN calls them the NY Mets or NY Giants.
     * There is only one New York NBA team (called New York) so that should be ignored. This is similar for Los Angeles.
     * Finally the chicago cubs and white sox are unique cases and set below.
     */
    if([specialCases count] == 3 && !([name rangeOfString:@"Red"].location != NSNotFound || [name rangeOfString:@"Blue "].location != NSNotFound || [name rangeOfString:@"Maple"].location != NSNotFound)){
        special = [NSString stringWithFormat:@"%@ %@", special, [specialCases objectAtIndex:1]];
    }
    if(![league isEqualToString:@"NBA"] && [special isEqualToString:@"New York"]){
        special = [NSString stringWithFormat:@"NY %@", [specialCases objectAtIndex:2]];
    }
    else if(![league isEqualToString:@"NHL"] && [special isEqualToString:@"Los Angeles"]){
        special = [NSString stringWithFormat:@"LA %@", [specialCases objectAtIndex:2]];
    }
    else if([name isEqualToString:@"Chicago Cubs"]){
        special = name;
    }
    else if([name isEqualToString:@"Chicago White Sox"]){
        special = @"Chicago Sox";
    }
    
    /* The standings tables are set using these HTML tags (different for MLB) are set below with the ESPN city (special)
     * name.
     */
    NSString *city;
    if([league isEqualToString:@"MLB"]){
        city = [NSString stringWithFormat:@"%@</a></td><td>", special];
    }
    else {
        city = [NSString stringWithFormat:@"%@</a>\n</td>\n<td>", special];
    }
    
    /* The league standings page are the same for all teams so they shouldn't be unnecessarily downloaded an extra
     * 29 or 31 times. They are stored in NSUserDefaults so this won't happen (the defaults are removed each time
     * the app opens so the standings can be refreshed). If it hasn't been downloaded yet it will download the correct
     * league page (see above code) and temporarily saved to the NSUserDefaults for that league. If it has been downloaded
     * the page will simply be retrieved from the NSUserDefaults (to NSString downloaded). Finally the downloaded HTML
     * page will be sorted through and the correct wins and losses will be derived. The wins and losses are subsequently
     * allocated to the team's record (an NSString) and its percentage is calculated (for correct standings).
     *
     */
    NSString *downloaded = [NSString stringWithFormat:@"%@Standings", league];
    if([[NSUserDefaults standardUserDefaults] objectForKey:downloaded] == nil){
      NSURL *standingsURL = [NSURL URLWithString:standingsString];
      NSError *error;
      NSString *standingsPage = [NSString stringWithContentsOfURL:standingsURL encoding:NSASCIIStringEncoding error:&error];
     
      [[NSUserDefaults standardUserDefaults] setObject:standingsPage forKey:downloaded];
        downloaded = standingsPage;
    }
    else{
        downloaded = [[NSUserDefaults standardUserDefaults] objectForKey:downloaded];
    }
      NSString *standingsPage = [[downloaded componentsSeparatedByString:city] objectAtIndex:1];
      NSString *wins = [[standingsPage componentsSeparatedByString:@"</td>"] objectAtIndex:0];
      NSString *losses = [[[[standingsPage componentsSeparatedByString:@"<td>"] objectAtIndex:1] componentsSeparatedByString:@"</td>"] objectAtIndex:0];
      newTeam.record = [NSString stringWithFormat:@"%@-%@", wins, losses];
      newTeam.pct = (double)[wins integerValue]/([wins integerValue]+[losses integerValue]);
	  return newTeam;
}

//encodes objects so these properties can be used in other classes

static NSString *NameKey = @"NameKey";
static NSString *LeagueKey = @"LeagueKey";
static NSString *CoachKey = @"CoachKey";
static NSString *LastChampKey = @"LastChampKey";
static NSString *DivisionKey = @"DivisionKey";
static NSString *HexKey = @"HexKey";
static NSString *RecordKey = @"RecordKey";
static NSString *ImgLinkKey = @"ImgLinkKey";
static NSString *LogoKey = @"LogoKey";

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:NameKey];
        _league = [aDecoder decodeObjectForKey:LeagueKey];
        _coach = [aDecoder decodeObjectForKey:CoachKey];
        _lastChamp = [aDecoder decodeObjectForKey:LastChampKey];
        _division = [aDecoder decodeObjectForKey:DivisionKey];
        _hex = [aDecoder decodeObjectForKey:HexKey];
        _record = [aDecoder decodeObjectForKey:RecordKey];
        _imgLink = [aDecoder decodeObjectForKey:ImgLinkKey];
        _logo = [aDecoder decodeObjectForKey:LogoKey];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:NameKey];
    [aCoder encodeObject:self.league forKey:LeagueKey];
    [aCoder encodeObject:self.coach forKey:CoachKey];
    [aCoder encodeObject:self.lastChamp forKey:LastChampKey];
    [aCoder encodeObject:self.division forKey:DivisionKey];
    [aCoder encodeObject:self.hex forKey:HexKey];
    [aCoder encodeObject:self.record forKey:RecordKey];
    [aCoder encodeObject:self.imgLink forKey:ImgLinkKey];
    [aCoder encodeObject:self.logo forKey:LogoKey];
}


@end
