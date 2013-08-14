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
    
	return newTeam;
}

//encodes objects so these properties can be used in other classes

static NSString *NameKey = @"NameKey";
static NSString *LeagueKey = @"LeagueKey";
static NSString *CoachKey = @"CoachKey";
static NSString *LastChampKey = @"LastChampKey";
static NSString *DivisionKey = @"DivisionKey";
static NSString *HexKey = @"HexKey";
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
    [aCoder encodeObject:self.imgLink forKey:ImgLinkKey];
    [aCoder encodeObject:self.logo forKey:LogoKey];
}


@end
