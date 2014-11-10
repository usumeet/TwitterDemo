//
//  ProfileViewController.m
//  Twitter
//
//  Created by Sumeet Ungratwar on 11/8/14.
//  Copyright (c) 2014 Sumeet Ungratwar. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import "User.h"

@interface ProfileViewController ()
/*
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screennameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetCount;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;
@property (weak, nonatomic) IBOutlet UILabel *followersCount;
 */

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    /*
    [self.backgroundImageView setImageWithURL:[NSURL URLWithString:self.user.backgroundImageUrl]];
    [self.profileImageView setImageWithURL:[NSURL URLWithString:self.user.profileImageUrl]];

    self.nameLabel.text = self.user.name;
    self.screennameLabel.text = @"@";
     self.screennameLabel.text = [self.screennameLabel.text stringByAppendingString:self.user.screenname];
    
    self.tweetCount.text = self.user.tweetCount;
    self.followingCount.text = self.user.followingCount;
    self.followersCount.text = self.user.followersCount;
     */
    
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
