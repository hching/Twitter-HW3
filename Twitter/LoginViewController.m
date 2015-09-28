//
//  LoginViewController.m
//  Twitter
//
//  Created by Henry Ching on 9/24/15.
//  Copyright © 2015 Henry Ching. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "User.h"
#import "TweetsViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (IBAction)onLogin:(id)sender {
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        if(user != nil) {
            //present
            NSLog(@"Welcome to %@", user.name);
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            UIViewController *controller = [mainStoryboard instantiateViewControllerWithIdentifier: @"mainNavigationController"];
            [self presentViewController:controller animated:YES completion:nil];
        } else {
            //error
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    User *user = [User currentUser];
    if(user != nil) {
        NSLog(@"Welcome %@", user.name);
        //[self presentViewController:[[TweetsViewController alloc] init] animated:YES completion:nil];
    } else {
        NSLog(@"Not logged in");
        //[self presentViewController:[[LoginViewController alloc] init] animated:YES completion:nil];
    }
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

@end
