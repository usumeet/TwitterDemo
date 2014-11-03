//
//  TwitterClient.h
//  Twitter
//
//  Created by Sumeet Ungratwar on 11/1/14.
//  Copyright (c) 2014 Sumeet Ungratwar. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *)sharedInstance;

- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion;

- (void)openURL:(NSURL *)url;

- (void)homeTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;

- (void)postTweetWithParams:(NSDictionary *)params completion:(void (^)(id response, NSError *error))completion;

- (void)retweetWithParams:(NSString *)identifier completion:(void (^)(id response, NSError *error))completion;

- (void)markFavourites:(NSDictionary *)params completion:(void (^)(id response, NSError *error))completion;

@end
