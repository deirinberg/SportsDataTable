//
//  ImageDownloader.m
//  Simple Table
//
//  Created by Dylan Eirinberg on 7/30/13.
//  Copyright (c) 2013 Dylan Eirinberg. All rights reserved.
//

#import "ImageDownloader.h"
#import "Team.h"
#import "Group.h"

@interface ImageDownloader ()
@property (nonatomic, strong) NSMutableData *activeDownload;
@property (nonatomic, strong) NSURLConnection *imageConnection;
@end

@implementation ImageDownloader

#pragma mark


//starts download of Image at url of the imgLink of the Team
- (void)startDownload:(BOOL)_isTeam;
{
    self.activeDownload = [NSMutableData data];
    
    isTeam = _isTeam;
    NSURLRequest *request;
    /* Max image size for team logo is (300,150) and starts an NSURLRequest for team's image link.
     * Max image size for group logo is (80, 80) and starts an NSURLRequest for group's image link.
     * An NSURLConnection is initialized and set to the url request and then is set to imageConnection.
     */
    if(isTeam == YES){
     request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.team.imgLink]];
     kImageMaxWidth = 300;
     kImageMaxHeight = 150;
    }
    else {
     request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.group.imgLink]];
     kImageMaxWidth = 80;
     kImageMaxHeight = 80;
    }
    
    // alloc+init and start an NSURLConnection; release on completion/failure
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    self.imageConnection = conn;
}


//If the download is canceled the url connection is canceled and set to nil and the mutable data is set to nil
- (void)cancelDownload
{
    [self.imageConnection cancel];
    self.imageConnection = nil;
    self.activeDownload = nil;
}

#pragma mark - NSURLConnectionDelegate

//The activeDownload stores the data when it receives it
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.activeDownload appendData:data];
}
/* When conncection fails clear the activeDownload property to allow later attempts and release the connection now that it's
 * finished
 */

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.activeDownload = nil;
    self.imageConnection = nil;
}

/* When the connection is finished loading the image is intialized with the donwloaded data. If the url image isn't
 * the desired size the image is resized keeping the same aspect ratio.
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *image = [[UIImage alloc] initWithData:self.activeDownload];
    float width, height;
     if((image.size.width/image.size.height)>=(kImageMaxWidth/kImageMaxHeight)){
         width = kImageMaxWidth;
         height = (image.size.height/image.size.width)*kImageMaxWidth;
      }
      else {
         width = (image.size.width/image.size.height)*kImageMaxHeight;
         height = kImageMaxHeight;
      }
    
    CGSize itemSize = CGSizeMake(width, height);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0f);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [image drawInRect:imageRect];
    
    if(isTeam == YES){
     self.team.logo = UIGraphicsGetImageFromCurrentImageContext();
    }
    else {
     self.group.logo = UIGraphicsGetImageFromCurrentImageContext();
    }
  
    UIGraphicsEndImageContext();

    self.activeDownload = nil;
    
    // Release the connection now that it's finished
    self.imageConnection = nil;
    
    // call our delegate and tell it that our icon is ready for display
    if (self.completionHandler)
        self.completionHandler();
}


@end
