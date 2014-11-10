//
//  MenuViewController.m
//  Twitter
//
//  Created by Sumeet Ungratwar on 11/8/14.
//  Copyright (c) 2014 Sumeet Ungratwar. All rights reserved.
//

#import "MenuViewController.h"
#import "UIImageView+AFNetworking.h"
#import "User.h"


@interface MenuViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Menu";
    User* user = [User currentUser];
    [self.posterView setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];
    self.nameLabel.text = user.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onProfileTap:(UITapGestureRecognizer *)sender {
    [self.delegate showProfilepage];
}

- (IBAction)onTimelineTap:(UITapGestureRecognizer *)sender {
    [self.delegate showTimeline];
    
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
