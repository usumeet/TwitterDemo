//
//  Tweet.h
//  Twitter
//
//  Created by Sumeet Ungratwar on 11/1/14.
//  Copyright (c) 2014 Sumeet Ungratwar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (strong, atomic) NSString *text;
@property (strong, atomic) NSDate *createdAt;
@property (strong, atomic) User *user;
@property (atomic, assign) NSInteger retweetCount;
@property (atomic, assign) NSInteger favouritesCount;
@property (atomic, strong) NSString *identifier;


- (id) initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)tweetsWithArray:(NSArray *)array;

@end
