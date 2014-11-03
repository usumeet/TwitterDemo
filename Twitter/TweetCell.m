//
//  TweetCell.m
//  Twitter
//
//  Created by Sumeet Ungratwar on 11/2/14.
//  Copyright (c) 2014 Sumeet Ungratwar. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

@interface TweetCell()
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screennameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptinoLabel;

@end

@implementation TweetCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet {
    self._tweet = tweet;
    [self.posterView setImageWithURL:[NSURL URLWithString:tweet.user.profileImageUrl]];
    self.nameLabel.text = tweet.user.name;
    self.screennameLabel.text = @"@";
    self.screennameLabel.text = [self.screennameLabel.text stringByAppendingString:tweet.user.screenname];
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
    timeFormatter.dateFormat = @"HH:mm:ss";
    self.timestampLabel.text = [timeFormatter stringFromDate:tweet.createdAt];
    
    self.descriptinoLabel.text = tweet.text;
}

@end
