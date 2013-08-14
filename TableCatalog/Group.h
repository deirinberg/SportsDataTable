//
//  Group.h
//  Simple Table
//
//  Created by Dylan Eirinberg on 8/5/13.
//  Copyright (c) 2013 Dylan Eirinberg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Group : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name; //name of group
@property (nonatomic, copy) NSString *type; //name of type of group (ex: NBA League or NFL NFC)
@property (nonatomic, copy) NSString *imgLink; //link to logo of group (nil if doesn't exist)
@property (nonatomic, copy) UIImage  *logo; //holds the logo of the image when downloaded

+ (instancetype)groupWithName:(NSString *)name type:(NSString *)type imgLink:(NSString *)imgLink; //info necessary to create a new group

@end
