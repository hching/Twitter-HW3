//
//  TwitterClient.m
//  Twitter
//
//  Created by Henry Ching on 9/24/15.
//  Copyright © 2015 Henry Ching. All rights reserved.
//

#import "TwitterClient.h"
#import "Tweet.h"

NSString * const kTwitterConsumerKey = @"3CzEGZChw1Ui3K3SF6vMz81LN";
NSString * const kTwitterConsumerSecret = @"oFMwWSXN3Ux3V1UUD6ml3AA5xTs0wMaksMLLxYRYlGfPhrlJQo";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com";

@interface TwitterClient()

@property(nonatomic, strong) void (^loginCompletion)(User *user, NSError *error);
@property(nonatomic, strong) void (^getTweetsCompletion)(NSArray *tweets, NSError *error);
@property(nonatomic, strong) void (^createTweetsCompletion)(NSDictionary *tweet, NSError *error);
@property(nonatomic, strong) void (^reTweetCompletion)(NSDictionary *tweet, NSError *error);

@end

@implementation TwitterClient

+ (TwitterClient *)sharedInstance {
    static TwitterClient *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(instance == nil) {
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl] consumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
        }
    });
    return instance;
}

- (void) loginWithCompletion:(void (^)(User *user, NSError *error))completion {
    self.loginCompletion = completion;
    
    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"mobiledemo://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
        NSLog(@"Got request token: %@", requestToken.token);
        
        NSURL *authUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
        [[UIApplication sharedApplication] openURL:authUrl];
        
    } failure:^(NSError *error) {
        NSLog(@"Failed: %@", error);
        self.loginCompletion(nil, error);
    }];
}

- (void) openURL:(NSURL *)url {
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuth1Credential credentialWithQueryString:url.query] success:^(BDBOAuth1Credential *accessToken) {
        NSLog(@"Got access token");
        [self.requestSerializer saveAccessToken:accessToken];
        
        [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //NSLog(@"Current User: %@", responseObject);
            
            User *user = [[User alloc] initWithDictionary:responseObject];
            [User setCurrentUser:user];
            NSLog(@"Current user name: %@", user.name);
            self.loginCompletion(user, nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Failed to get user");
            self.loginCompletion(nil, error);
        }];
        
    } failure:^(NSError *error) {
        NSLog(@"Failed: %@", error);
        self.loginCompletion(nil, error);
    }];
}

- (void) getTweets:(void (^)(NSArray *tweets, NSError *error))completion {
    self.getTweetsCompletion = completion;
    [self GET:@"1.1/statuses/user_timeline.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"Tweets: %@", responseObject);
        NSArray *tweets = [Tweet tweetsWithArray:responseObject];
        self.getTweetsCompletion(tweets, nil);
        //for(Tweet *tweet in tweets) {
            //NSLog(@"tweet: %@, createdAt: %@", tweet.text, tweet.createdAt);
        //}
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed to get user");
        self.getTweetsCompletion(nil, error);
    }];
}

- (void)createTweet:(NSString *)status completion:(void(^)(NSDictionary *tweet, NSError *error))completion {
    self.createTweetsCompletion = completion;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"status": status}];
    [self POST:@"1.1/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *tweet = [[NSDictionary alloc] initWithDictionary:responseObject];
        self.createTweetsCompletion(tweet, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed");
        self.createTweetsCompletion(nil, error);
    }];
}

- (void)reTweet:(NSString *)tweetId completion:(void(^)(NSDictionary *tweet, NSError *error))completion {
    self.reTweetCompletion = completion;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"id": tweetId}];
    [self POST:[NSString stringWithFormat:@"1.1/statuses/retweet/%@.json", tweetId] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *tweet = [[NSDictionary alloc] initWithDictionary:responseObject];
        self.reTweetCompletion(tweet, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed retweet: %@", error);
        self.reTweetCompletion(nil, error);
    }];
}

@end
