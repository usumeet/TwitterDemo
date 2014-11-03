//
//  User.h
//  Twitter
//
//  Created by Sumeet Ungratwar on 11/1/14.
//  Copyright (c) 2014 Sumeet Ungratwar. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const UserDidLoginNotification;
extern NSString * const UserDidLogoutNotification;

@interface User : NSObject


@property (strong, atomic) NSString *name;
@property (strong, atomic) NSString *screenname;
@property (strong, atomic) NSString *profileImageUrl;
@property (strong, atomic) NSString *tagline;


- (id) initWithDictionary:(NSDictionary *)dictionary;


+ (User *)currentUser;

+ (void)setCurrentUser:(User *)user;

+ (void)logout;

@end
