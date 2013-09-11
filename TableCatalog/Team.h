//
//  Team.h
//  Simple Table
//
//  Created by Dylan Eirinberg on 7/29/13.
//  Copyright (c) 2013 Dylan Eirinberg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Team : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name; //name of team
@property (nonatomic, copy) NSString *league; //league team is in (ex: NBA)
@property (nonatomic, copy) NSString *coach; //current coach of team
@property (nonatomic, copy) NSString *lastChamp; //last year they won a championship (- for never)
@property (nonatomic, copy) NSString *division; //division of team (ex: Central)
@property (nonatomic, copy) NSString *hex; //hex string of main color of logo
@property (nonatomic, copy) NSString *record;
@property (nonatomic)       double   pct;      //team winning percentage
@property (nonatomic, copy) NSString *imgLink; //link to logo of image
@property (nonatomic, copy) UIImage  *logo; //holds the logo of the image when downloaded

+ (instancetype)teamWithName:(NSString *)name league:(NSString *)league coach:(NSString *)coach lastChamp:(NSString *)lastChamp division:(NSString *)division hex:(NSString *)hex imgLink:(NSString *)imgLink; //info necessary to create a new team

@end
