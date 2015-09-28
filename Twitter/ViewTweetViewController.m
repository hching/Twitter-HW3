//
//  ViewTweetViewController.m
//  Twitter
//
//  Created by Henry Ching on 9/27/15.
//  Copyright © 2015 Henry Ching. All rights reserved.
//

#import "ViewTweetViewController.h"
#import "User.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "TweetTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface ViewTweetViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *tweetTypeImage;
@property (weak, nonatomic) IBOutlet UILabel *tweetTypeText;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userTwitterName;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UILabel *createAtText;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountText;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCountText;

@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@end

@implementation ViewTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.userName.text = self.guserName;
    self.userTwitterName.text = self.guserTwitterName;
    [self.userImage setImageWithURL:self.guserImage];
    self.tweetText.text = self.gtweetText;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onReply:(id)sender {
    
}

- (IBAction)onRetweet:(UIButton *)sender {
    [[TwitterClient sharedInstance] reTweet:self.gtweetId completion:^(NSDictionary *tweet, NSError *error) {
        if(tweet != nil) {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            UIViewController *controller = [mainStoryboard instantiateViewControllerWithIdentifier: @"mainNavigationController"];
            [self presentViewController:controller animated:YES completion:nil];
        } else {
            //error
        }
    }];
}

- (IBAction)onFavorite:(UIButton *)sender {
}

@end
