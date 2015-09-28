//
//  Tweet.h
//  Twitter
//
//  Created by Henry Ching on 9/26/15.
//  Copyright © 2015 Henry Ching. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSString *tweetId;
@property (nonatomic, strong) User *user;

- (id) initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)tweetsWithArray:(NSArray *)array;

@end
