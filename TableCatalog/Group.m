//
//  Group.m
//  Simple Table
//
//  Created by Dylan Eirinberg on 8/5/13.
//  Copyright (c) 2013 Dylan Eirinberg. All rights reserved.
//

#import "Group.h"

@implementation Group

/* Creates and returns a new team with the passed in properties. The image link is set after content.sportslogos.net where
 * all the logo images I used are stored.
 */
+ (instancetype)groupWithName:(NSString *)name type:(NSString *)type imgLink:(NSString *)imgLink {
    
	Group *newGroup = [[self alloc] init];
    newGroup.name = name;
    newGroup.type = type;
    if(![imgLink isEqualToString:@"nil"]){
     newGroup.imgLink = [NSString stringWithFormat:@"http://content.sportslogos.net%@", imgLink];
    }
    else {
     newGroup.imgLink = imgLink;
    }
	return newGroup;
}


//encodes objects so these properties can be used in other classes

static NSString *NameKey = @"NameKey";
static NSString *TypeKey = @"TypeKey";
static NSString *ImgLinkKey = @"ImgLinkKey";
static NSString *LogoKey = @"LogoKey";

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:NameKey];
        _type = [aDecoder decodeObjectForKey:TypeKey];
        _imgLink = [aDecoder decodeObjectForKey:ImgLinkKey];
        _logo = [aDecoder decodeObjectForKey:LogoKey];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:NameKey];
    [aCoder encodeObject:self.type forKey:TypeKey];
    [aCoder encodeObject:self.imgLink forKey:ImgLinkKey];
    [aCoder encodeObject:self.logo forKey:LogoKey];
}


@end