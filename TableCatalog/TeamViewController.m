//
//  TeamViewController.m
//  TableCatalog
//
//  Created by Dylan Eirinberg on 8/6/13.
//  Copyright (c) 2013 Dylan Eirinberg. All rights reserved.
//

#import "TeamViewController.h"
#import "Team.h"
#import "ImageDownloader.h"
#import "Reachability.h"

@interface TeamViewController ()
@property (nonatomic, strong) NSMutableDictionary *imageDownloadInProgress; //stores data for downloading image
@end

@implementation TeamViewController

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
    
    // Sets background color of view to UIColor from hex string of team property
    self.view.backgroundColor = [self SKColorFromHexString:self.team.hex];
    
    //imageDownloadInProgress is initialized as an NSMutableDictionary
    self.imageDownloadInProgress = [NSMutableDictionary dictionary];
    
    /* If a logo for the team hasn't been downloaded the internet conncetion is tested. If there isn't
     * Internet a "?" image will be set. If there is a logo it wil be set and resized to the same aspect ratio.
     * If there is Internet and the logo hasn't been downloaded it will be via a helper function.
     */
    if(!self.team.logo){
        Reachability *r = [Reachability reachabilityWithHostName:@"m.google.com"];
        NetworkStatus internetStatus = [r currentReachabilityStatus];
        if(internetStatus == NotReachable){
            if(self.alertShown == NO){
                UIAlertView *errorAlertView = [[UIAlertView alloc]
                                               initWithTitle:@"No internet connection"
                                               message:@"Logos require internet to be downloaded"
                                               delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [errorAlertView show];
                self.alertShown = YES;
            }
            self.logo.image = [UIImage imageNamed:@"NoLogo.png"];
        }
        else {
         [self startImageDownload:self.team];
        }
    }
    else {
        self.logo.contentMode = UIViewContentModeScaleAspectFit;
        [self.logo setImage:self.team.logo];
        [self.logo sizeToFit];
        self.logo.frame = CGRectMake((self.view.frame.size.width/2)-(self.logo.image.size.width/2), 10, self.team.logo.size.width, self.team.logo.size.height);
    }
    
    /* The coach and champ text color is set to store variable depending on the background color for readability.
     * The coach text is then set based on the league--Manager for MLB and Coach for all other leagues. The championships
     * are formatted by what the championship are called. The labels are then resized to fit the content and centered
     * in the view.
     */
    
    self.coach.contentMode = UIViewContentModeScaleAspectFit;
    self.coach.textColor = self.textColor;
     if([self.team.league isEqualToString:@"MLB"]){
       self.coach.text = [NSString stringWithFormat:@"Manager: %@", self.team.coach];
     }
     else {
        self.coach.text = [NSString stringWithFormat:@"Coach: %@", self.team.coach];
     }
    [self.coach sizeToFit];
    self.coach.frame = CGRectMake((self.view.frame.size.width/2)-(self.coach.frame.size.width/2), 200, self.coach.frame.size.width, self.coach.frame.size.height);
    
    self.champ.contentMode = UIViewContentModeScaleAspectFit;
    self.champ.textColor = self.textColor;
    
    if([self.team.league isEqualToString:@"NFL"]){
        self.champ.text = [NSString stringWithFormat:@"Last Super Bowl: %@", self.team.lastChamp];
    }
    else if([self.team.league isEqualToString:@"MLB"]){
        self.champ.text = [NSString stringWithFormat:@"Last World Series: %@", self.team.lastChamp];
    }
    else if([self.team.league isEqualToString:@"NHL"]){
        self.champ.text = [NSString stringWithFormat:@"Last Stanley Cup: %@", self.team.lastChamp];
    }
    else {
        self.champ.text = [NSString stringWithFormat:@"Last Championship: %@", self.team.lastChamp];
    }
    [self.champ sizeToFit];
    self.champ.frame = CGRectMake((self.view.frame.size.width/2)-(self.champ.frame.size.width/2), 270, self.champ.frame.size.width, self.champ.frame.size.height);
    
}

-(void)viewWillAppear:(BOOL)animated{
    //The logo resizes to fit the logo image when the view appears
    [self.logo sizeToFit];
}


- (void)startImageDownload:(Team *)team {
    /* The ImageDownloader class is initialized here and the current team is passed to it. The download is started
     * "YES" parameter specifiying it is a Team logo and the activity indicator animates. When the image loads the
     * logo image is set to the new team.logo and the logo is resized and centered.
     */
    ImageDownloader *imageDownloader = [[ImageDownloader alloc] init];
    imageDownloader.team = team;
    
    [imageDownloader setCompletionHandler:^{
        // Display the newly loaded image
        [self.activity stopAnimating];
        self.logo.contentMode = UIViewContentModeScaleAspectFit;
        self.logo.image = team.logo;
        [self.logo sizeToFit];
        self.logo.frame = CGRectMake((self.view.frame.size.width/2)-(self.logo.image.size.width/2), 10, self.logo.frame.size.width, self.logo.frame.size.height);
    }];
    [imageDownloader startDownload:YES];
    if(self.textColor == [UIColor whiteColor]){
        self.activity.color = [UIColor whiteColor];
    }
    else {
        self.activity.color = [UIColor grayColor];
    }
    [self.activity startAnimating];
}


-(void)SKScanHexColor:(NSString *)hexString with:(float *)red with:(float *)green with:(float *)blue with:(float *)alpha {
    // To convert a hex string to a UIColor I used the code from this link: http://stackoverflow.com/questions/3805177/how-to-convert-hex-rgb-color-codes-to-uicolor

    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    if (red) { *red = ((baseValue >> 24) & 0xFF)/255.0f; }
    if (green) { *green = ((baseValue >> 16) & 0xFF)/255.0f; }
    if (blue) { *blue = ((baseValue >> 8) & 0xFF)/255.0f; }
    if (alpha) { *alpha = ((baseValue >> 0) & 0xFF)/255.0f; }
}

-(UIColor *)SKColorFromHexString:(NSString *)hexString {
    float red, green, blue, alpha;
    [self SKScanHexColor:hexString with:&red with:&green with:&blue with:&alpha]; //reference variables store the values from the other functions
    
    //This formula converts the UIColor rgb values to a grayscale value (0 to 1)
    float grayscale = red*0.2989 + green*0.5870 + blue*0.1140;
    /* If the grayscale value is less than 0.5 the background is dark and the text needs to be white to read it.
     * If the grayscale value is greater than 0.5 then the background is light and the text needs to be dark.
     */
    if(grayscale <= 0.5){
        self.textColor = [UIColor whiteColor];
    }
    else {
        self.textColor = [UIColor blackColor];
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

// If there is a memory warning the download will be canceled and downloaded information will be deleted
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // terminate all pending download connections
    NSArray *allDownloads = [self.imageDownloadInProgress allValues];
    [allDownloads makeObjectsPerformSelector:@selector(cancelDownload)];
    
    [self.imageDownloadInProgress removeAllObjects];
}

@end
