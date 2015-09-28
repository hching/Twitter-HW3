//
//  ViewTweetViewController.h
//  Twitter
//
//  Created by Henry Ching on 9/27/15.
//  Copyright © 2015 Henry Ching. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewTweetViewController : UIViewController

@property (strong, nonatomic) NSString *gtweetTypeImage;
@property (strong, nonatomic) NSString *gtweetTypeText;
@property (strong, nonatomic) NSURL *guserImage;
@property (strong, nonatomic) NSString *guserName;
@property (strong, nonatomic) NSString *guserTwitterName;
@property (strong, nonatomic) NSString *gtweetText;
@property (strong, nonatomic) NSString *gcreateAtText;
@property (strong, nonatomic) NSString *gretweetCountText;
@property (strong, nonatomic) NSString *gfavoriteCountText;
@property (strong, nonatomic) NSString *gtweetId;

@end
