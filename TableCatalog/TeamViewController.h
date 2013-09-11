//
//  TeamViewController.h
//  TableCatalog
//
//  Created by Dylan Eirinberg on 8/6/13.
//  Copyright (c) 2013 Dylan Eirinberg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Team;

@interface TeamViewController : UIViewController 

@property (nonatomic, retain) Team *team; //the team and all its data passed to this view controller
@property (nonatomic, retain) IBOutlet UIImageView *logo; //the logo of the team
@property (nonatomic, retain) UIColor *textColor; //the color (black or white) for all text
@property (nonatomic, retain) IBOutlet UILabel *coach; //coach of the team
@property (nonatomic, retain) IBOutlet UILabel *champ; //year of the last championship the team won
@property (nonatomic, retain) IBOutlet UILabel *record; //year of the last championship the team won
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activity; //activity animates when logo is loading
@property (nonatomic) BOOL alertShown; //if alert for no Internet has been shown or not

-(void)SKScanHexColor:(NSString *)hexString with:(float *)red with:(float *)green with:(float *)blue with:(float *)alpha; //reads in a hex value (NSString format)
-(UIColor *)SKColorFromHexString:(NSString *)hexString; //returns UIColor from hex string
@end
