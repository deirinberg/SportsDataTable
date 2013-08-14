//
//  ImageDownloader.h
//  Simple Table
//
//  Created by Dylan Eirinberg on 7/30/13.
//  Copyright (c) 2013 Dylan Eirinberg. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Team, Group;

@interface ImageDownloader : NSObject {
    bool isTeam; //stores if image downloaded is a team logo or group logo
    int kImageMaxWidth, kImageMaxHeight; //stores max image width and max image height
}

@property (nonatomic, strong) Team *team; //stores team so it can set the logo for it when downloaded it
@property (nonatomic, strong) Group *group; //stores group so it can set the logo for it when downloaded it
@property (nonatomic, copy) void (^completionHandler)(void); //says if image is downloaded or not

- (void)startDownload:(BOOL)_isTeam; //called to start download. Parameter _isTeam is if image downloaded is a team or group logo
- (void)cancelDownload; //cancels the download if there is a memory warning

@end
