//
//  NewTweetViewController.m
//  Twitter
//
//  Created by Sumeet Ungratwar on 11/2/14.
//  Copyright (c) 2014 Sumeet Ungratwar. All rights reserved.
//

#import "NewTweetViewController.h"
#import "UIImageView+AFNetworking.h"
#import "User.h"
#import "TwitterClient.h"

@interface NewTweetViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screennameLabel;
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
@property (strong, nonatomic) UIBarButtonItem *countButton;
@end

@implementation NewTweetViewController

- (void)onCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onNewTweet {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"status"] = self.inputTextView.text;
    [[TwitterClient sharedInstance] postTweetWithParams:dictionary completion:^(id response, NSError *error) {
        NSLog(@"Got response after posting tweet %@ and error: %@", response, error);
        self.inputTextView.text = @"";
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.countButton = [[UIBarButtonItem alloc] initWithTitle:@"0" style:UIBarButtonItemStylePlain target:self action:@selector(nilSymbol)];
    self.inputTextView.delegate = self;
    
    User *user = [User currentUser];
    [self.posterView setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];
    self.nameLabel.text = user.name;
    self.screennameLabel.text = @"@";
    self.screennameLabel.text = [self.screennameLabel.text stringByAppendingString:user.screenname];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onNewTweet)];
    NSArray *actionButtonItems = @[rightButton, self.countButton];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
    //self.navigationItem.rightBarButtonItem = rightButton;
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancel)];
    self.navigationItem.leftBarButtonItem = leftButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Text View Delegate methods

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (textView.text.length + text.length > 140) {
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    self.countButton.title = [NSString stringWithFormat:@"%lu", (unsigned long)textView.text.length];
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    self.countButton.title = [NSString stringWithFormat:@"%lu", (unsigned long)textView.text.length];
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
