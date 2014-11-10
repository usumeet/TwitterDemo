//
//  DummyViewController.m
//  Twitter
//
//  Created by Sumeet Ungratwar on 11/8/14.
//  Copyright (c) 2014 Sumeet Ungratwar. All rights reserved.
//

#import "DummyViewController.h"
#import "UIImageView+AFNetworking.h"


@interface DummyViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screennameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetCount;
@property (weak, nonatomic) IBOutlet UILabel *followerCount;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;

@end

@implementation DummyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.backgroundImageView setImageWithURL:[NSURL URLWithString:self.user.backgroundImageUrl]];
    [self.profileImageView setImageWithURL:[NSURL URLWithString:self.user.profileImageUrl]];
    self.nameLabel.text = self.user.name;
    self.screennameLabel.text = self.user.screenname;
    self.tweetCount.text = [NSString stringWithFormat:@"%ld\nTWEETS", self.user.tweetCount];
    self.followingCount.text = [NSString stringWithFormat:@"%ld\nFOLLOWING", self.user.followingCount];
    self.followerCount.text = [NSString stringWithFormat:@"%ld\nFOLLOWERS", self.user.followersCount];
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
