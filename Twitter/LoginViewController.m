//
//  LoginViewController.m
//  Twitter
//
//  Created by Sumeet Ungratwar on 11/1/14.
//  Copyright (c) 2014 Sumeet Ungratwar. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#include "TweetsViewController.h"

@interface LoginViewController ()
- (IBAction)onLogin:(id)sender;

@end

@implementation LoginViewController

- (IBAction)onLogin:(id)sender {
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        if (user != nil) {
            // Modally present the tweets view
            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[[TweetsViewController alloc] init]] animated:YES completion:nil];
            NSLog(@"Welcome to Twitter, %@", user.name);
        }
        if (error != nil ) {
            // Present the error view
            NSLog(@"loginWithCompletion returned an error");
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
