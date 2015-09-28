//
//  CreateTweetViewController.m
//  Twitter
//
//  Created by Henry Ching on 9/27/15.
//  Copyright © 2015 Henry Ching. All rights reserved.
//

#import "CreateTweetViewController.h"
#import "User.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "TweetTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface CreateTweetViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userTwitterName;
@property (weak, nonatomic) IBOutlet UITextView *tweetText;

@end

@implementation CreateTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.userName.text = self.guserName;
    self.userTwitterName.text = self.guserTwitterName;
    [self.userImage setImageWithURL:self.guserImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTweet:(UIBarButtonItem *)sender {
    [[TwitterClient sharedInstance] createTweet:self.tweetText.text completion:^(NSDictionary *tweet, NSError *error) {
        if(tweet != nil) {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            UIViewController *controller = [mainStoryboard instantiateViewControllerWithIdentifier: @"mainNavigationController"];
            [self presentViewController:controller animated:YES completion:nil];
        } else {
            //error
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
