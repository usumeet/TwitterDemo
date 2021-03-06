//
//  TweetCell.h
//  Twitter
//
//  Created by Sumeet Ungratwar on 11/2/14.
//  Copyright (c) 2014 Sumeet Ungratwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetCell : UITableViewCell

@property (strong, nonatomic) Tweet *_tweet;

- (void)setTweet:(Tweet *)tweet;

@property (weak, nonatomic) IBOutlet UIImageView *posterView;

@end
